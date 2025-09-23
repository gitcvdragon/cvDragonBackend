<?php

namespace App\Http\Controllers\Api\website\Subscription;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\CreateCvuserprofile;
use App\Models\CvProfileSection;
use App\Traits\ApiResponseTrait;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;   // <-- Add this line
use Carbon\Carbon;
class MySubscriptionController extends Controller
{
    use ApiResponseTrait;

    public function getActiveSubscriptions(Request $request)
{
    // Get all active subscriptions
    $userId = auth()->user()->id;
    $subscriptions = DB::table('user-subscription')
    ->select('design','activate','expiry')
        ->where('user_id', $userId)
        ->where('status', 1)
        ->where('expiry', '>=', now())
        ->get();

    if ($subscriptions->isEmpty()) {
        return $this->errorResponse('No active subscriptions found.', 404);
    }

    // Loop through each subscription and attach design + category
    $subscriptions->transform(function ($subscription) {

        $subscription->daysLeft = \Carbon\Carbon::now()->diffInDays(
            \Carbon\Carbon::parse($subscription->expiry),
            false
        );

        if ($subscription->design == 0) {
            // Pro subscription case
            $subscription->designDetails = (object)[
                'designName' => 'Pro Subscription',
                'categoryid' => null,
                'category'   => null,
            ];
        } else {
            // Normal design subscription case
            $design = DB::table('resource-profiledesign')
                ->select('designName','categoryid')
                ->where('designid', $subscription->design)
                ->where('status', 1)
                ->first();

            if ($design) {
                // Fetch design category
                $category = DB::table('resource_profile_design_categories')
                    ->select('title')
                    ->where('id', $design->categoryid)
                    ->where('status', 1)
                    ->first();

                $design->category = $category ? $category->title : null;
            }

            $subscription->designDetails = $design;
        }

        return $subscription;
    });

    return $this->successResponse([
        'subscriptions' => $subscriptions
    ], 'All active subscriptions fetched successfully!');
}

public function redeemVoucher(Request $request)
{

    $validator = Validator::make($request->all(), [
        'voucherSN'   => 'required|string',
        'voucherCode' => 'required|string',
    ]);

    if ($validator->fails()) {
        return $this->errorResponse($validator->errors()->first(), 422);
    }

    $userId = auth()->user()->id;

    // Step 1: check voucher validity
    $voucher = DB::table('uservoucherdetails')
        ->where('voucherSN', $request->voucherSN)
        ->where('voucherCode', $request->voucherCode)
        ->where('status', 1) // unused
        ->first();

    if (!$voucher) {
        return $this->errorResponse('Invalid or already used voucher.', 400);
    }

    // Step 2: calculate subscription dates
    $activate = now();
    $expiry   = now()->addDays((int) $voucher->voucherDuration);

    // Step 3: insert into user-subscription
    $subscriptionId = DB::table('user-subscription')->insertGetId([
        'user_id'     => $userId,
        'design'      => $voucher->voucherDesign, // can be 0 for Pro
        'activate'    => $activate,
        'expiry'      => $expiry,
        'securityKey' => Str::random(12), // random unique key
        'dateCreated' => now(),
        'dateUpdated' => now(),
        'status'      => 1, // active
        'created_at'  => now(),
        'updated_at'  => now(),
    ]);

    // Step 4: mark voucher as used
    DB::table('uservoucherdetails')
        ->where('sn', $voucher->sn)
        ->update([
            'status' => 0,
            'notifyDetails' => 'Used by user ' . $userId,
        ]);

    return $this->successResponse([
        'subscription_id' => $subscriptionId,
        'activate'        => $activate,
        'expiry'          => $expiry,
    ], 'Voucher redeemed successfully and subscription activated!');
}



public function createSubscriptionOrder(Request $request)
{
    $validator = Validator::make($request->all(), [
        'microservice_sn' => 'required|integer|exists:microservice,sn',
    ]);

    if ($validator->fails()) {
        return $this->errorResponse($validator->errors()->first(), 422);
    }

    DB::beginTransaction();

    try {
        $user = auth()->user();
        $microserviceSn = $request->microservice_sn;

        $microservice = DB::table('microservice')->where('sn', $microserviceSn)->first();

        if (!$microservice) {
            DB::rollBack();
            return $this->errorResponse('Subscription not found', 404);
        }

        $cost = $microservice->cost;
        $totalDays = $microservice->days ?? 30;
        $activateDate = now();
        $expiryDate = Carbon::parse($activateDate)->addDays($totalDays);

        // Check if an order for this user+subscription already exists in initialized state
        $existingOrder = DB::table('orders')
            ->where('user_id', $user->id)
            ->where('service_sn', $microserviceSn)
            ->where('payment_status', 'initialized')
            ->first();

        if ($existingOrder) {
            // Update the existing initialized order
            DB::table('orders')
                ->where('orderid', $existingOrder->orderid)
                ->update([
                    'total_amount' => $cost,
                    'activate_date' => $activateDate,
                    'expiry_date' => $expiryDate,
                    'created_at' => now(),
                    'updated_at' => now()
                ]);

            $orderId = $existingOrder->orderid;
        } else {
            // Create a new order

            $orderId = DB::table('orders')->insertGetId([
                'user_id' => $user->id,
                'service_sn' => $microserviceSn,
                'total_amount' => $cost,
                'order_date' => now(),
                'payment_status' => 'initialized',
                'activate_date' => $activateDate,
                'expiry_date' => $expiryDate,
                'all_steps_completed' => 0,
                'transaction_sn' => null,
                'is_refund' => 0,
                'is_cancled' => 0,
                'admin_comment' => null,
                'created_at' => now(),
                'updated_at' => now()
            ]);
        }

        DB::commit();

        return $this->successResponse([
            'order_id' => $orderId,
        ]);

    } catch (\Exception $e) {
        DB::rollBack();
        return $this->errorResponse('Failed to create subscription order: ' . $e->getMessage(), 500);
    }
}
public function createRazorpayOrder(Request $request)
{
    $validator = Validator::make($request->all(), [
        'order_id' => 'required|string|exists:orders,orderid',
        'payment_mode' => 'required|string',
    ]);

    if ($validator->fails()) {
        return $this->errorResponse($validator->errors()->first(), 422);
    }

    DB::beginTransaction();

    try {
        $user = auth()->user();
        $orderId = $request->order_id;
        $paymentMode = $request->payment_mode ?? 'Online';

        // Fetch order
        $order = DB::table('orders')->where('orderid', $orderId)->first();
        if (!$order) {
            DB::rollBack();
            return $this->errorResponse('Order not found', 404);
        }

        // Create Razorpay order
        $razorpay = new \Razorpay\Api\Api(env('RAZORPAY_KEY'), env('RAZORPAY_SECRET'));

        $razorpayOrder = $razorpay->order->create([
            'receipt'         => $orderId,
            'amount'          => intval($order->total_amount * 100), // in paise
            'currency'        => 'INR',
            'payment_capture' => 1
        ]);

        // Insert transaction record
        $transactionId = DB::table('transactions')->insertGetId([
            'orderid'          => $orderId,
            'id'               => $user->id,
            'payment_status'   => 'created',
            'paymentMode'      => $paymentMode,
            'currency'         => 'INR',
            'totalAmount'      => $order->total_amount,
            'transactionDate'  => now(),
            'status'           => 1,
            'razorpay_order_id'=> $razorpayOrder['id'],
            'created_at'       => now(),
            'updated_at'       => now(),
            'feature' => 'microservice',
                'feature_sn' => $order->service_sn,


                'sub_feature' => 'orders',
                'sub_feature_sn' => $orderId,
        ]);

        DB::commit();

        return $this->successResponse([
            'order_id' => $orderId,
            'razorpay_order_id' => $razorpayOrder['id'],
            'transaction_id' => $transactionId,
        ]);

    } catch (\Exception $e) {
        DB::rollBack();
        return $this->errorResponse('Failed to create Razorpay order: ' . $e->getMessage(), 500);
    }
}

public function subscriptionVerifyPayment(Request $request)
{
    $request->validate([
        'razorpay_payment_id' => 'required|string',
        'razorpay_order_id'   => 'required|string|exists:transactions,razorpay_order_id',
        'razorpay_signature'  => 'required|string',
    ]);

    DB::beginTransaction();

    try {
        $user = auth()->user();
        $transaction = DB::table('transactions')
            ->where('razorpay_order_id', $request->razorpay_order_id)
            ->first();

        if (!$transaction) {
            DB::rollBack();
            return $this->errorResponse('Transaction not found', 404);
        }

        // Verify Razorpay signature
        $api = new \Razorpay\Api\Api(env('RAZORPAY_KEY'), env('RAZORPAY_SECRET'));
        try {
            $api->utility->verifyPaymentSignature([
                'razorpay_order_id'   => $request->razorpay_order_id,
                'razorpay_payment_id' => $request->razorpay_payment_id,
                'razorpay_signature'  => $request->razorpay_signature,
            ]);
        } catch (\Razorpay\Api\Errors\SignatureVerificationError $e) {
            // Mark transaction as failed
            DB::table('transactions')->where('razorpay_order_id', $request->razorpay_order_id)
                ->update(['payment_status' => 'failed', 'status' => 0, 'updated_at' => now()]);
            DB::rollBack();
            return $this->errorResponse('Payment verification failed: ' . $e->getMessage(), 400);
        }

        // Update transaction as success
        DB::table('transactions')->where('razorpay_order_id', $request->razorpay_order_id)
            ->update([
                'razorpay_payment_id' => $request->razorpay_payment_id,
                'payment_status' => 'success',
                'status' => 1,
                'updated_at' => now()
            ]);

        $order = DB::table('orders')->where('orderid', $transaction->orderid)->first();
        if (!$order) {
            DB::rollBack();
            return $this->errorResponse('Order not found', 404);
        }

        // Create user subscription
        $activate = now();
        $expiry = Carbon::parse($activate)->addDays($order->total_amount ?? 30);

        DB::table('user-subscription')->insert([
            'user_id'    => $user->id,
            'service_sn' => $transaction->feature_sn,
            'activate'   => $activate,
            'expiry'     => $expiry,
            'securityKey'=> Str::random(19),
            'status'     => 1,
            'dateCreated'=> $activate,
            'dateUpdated'=> now(),
            'created_at' => now(),
            'updated_at' => now()
        ]);

        DB::commit();

        return $this->successResponse([
            'message' => 'Payment verified and subscription activated successfully',
            'subscription' => [
                'user_id'    => $user->id,
                'service_sn' => $transaction->feature_sn,
                'activate'   => $activate,
                'expiry'     => $expiry,
            ]
        ]);

    } catch (\Exception $e) {
        DB::rollBack();
        return $this->errorResponse('Failed to verify payment: ' . $e->getMessage(), 500);
    }
}


}
