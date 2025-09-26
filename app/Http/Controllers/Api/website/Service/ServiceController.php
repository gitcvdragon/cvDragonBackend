<?php

namespace App\Http\Controllers\Api\website\Service;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Tymon\JWTAuth\Facades\JWTAuth;
use Razorpay\Api\Api;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Validator;
use Carbon\Carbon;
use App\Traits\ApiResponseTrait;

class ServiceController extends Controller
{
    use ApiResponseTrait;
    /**
     * Get all active services for the logged-in user
     */

public function activeServices(Request $request)
{
    try {
        $user = auth()->user();

        $services = DB::table('user_services as us')
            ->join('microservice as ms', 'us.microservice_id', '=', 'ms.sn')
            ->leftJoin('service_steps as fs', function ($join) {
                $join->on('fs.microservice_id', '=', 'us.microservice_id')
                     ->where('fs.step_order', '=', 1);
            })
            ->leftJoin('orders as o', 'us.order_id', '=', 'o.orderid')
            ->leftJoin('transactions as t', 't.orderid', '=', 'us.order_id')
            ->where('us.id', $user->id)
            ->where('us.status', 1)
            ->where(function ($q) {
                $q->whereNull('o.expiry_date')
                  ->orWhere('o.expiry_date', '>=', now());
            })
            ->select(
                DB::raw('MAX(us.sn) as user_step_id'),
                'us.microservice_id',
                'us.order_id',
                'ms.category as service_name',
                'ms.days',
                'ms.microsite',
                'ms.heading',
                'ms.persons_image',
                'ms.purchases',
                'ms.button',
                'fs.post_text as first_post_text',
                'o.activate_date as order_activate_date',
                DB::raw('MAX(us.created_at) as created_at'),
                DB::raw('DATEDIFF(o.expiry_date, NOW()) as days_left'),
                't.totalAmount as transaction_amount',
                't.paymentMode'
            )
            ->groupBy(
                'us.microservice_id',
                'us.order_id',
                'ms.category',
                'ms.days',
                'ms.microsite',
                'ms.heading',
                'ms.persons_image',
                'ms.purchases',
                'ms.button',
                'fs.post_text',
                'o.activate_date',
                't.totalAmount',
                't.paymentMode',
			'o.expiry_date'

            )
            ->orderBy('created_at', 'desc')
            ->get();

        // Attach steps for each service
        foreach ($services as $service) {

            $service->persons_image = !empty($service->persons_image)
                ? json_decode($service->persons_image, true)
                : [];

            // fetch all steps for this microservice
            $steps = DB::table('service_steps')
                ->where('microservice_id', $service->microservice_id)
                ->orderBy('step_order', 'asc')
                ->get();

            // fetch all user step statuses for this order+service
            $userSteps = DB::table('user_services')
                ->where('order_id', $service->order_id)
                ->where('microservice_id', $service->microservice_id)
                ->pluck('step_status', 'current_step_id');

            $stepDetails = [];
            foreach ($steps as $step) {
                $status = $userSteps[$step->sn] ?? 'not_started';
                $text = $step->pre_text;

                if ($status === 'completed') {
                    $text = $step->post_text;
                } elseif ($status === 'in_progress') {
                    $text = $step->inprogress_text;
                }

                $remarks = DB::table('user_services')
                    ->where('order_id', $service->order_id)
                    ->where('microservice_id', $service->microservice_id)
                    ->where('id', $user->id)
                    ->where('current_step_id', $step->sn)
                    ->value('remarks');

                $completedAt = null;
                if ($status === 'completed') {
                    $completedAt = DB::table('user_services')
                        ->where('order_id', $service->order_id)
                        ->where('microservice_id', $service->microservice_id)
                        ->where('id', $user->id)
                        ->where('current_step_id', $step->sn)
                        ->value('created_at');
                }

                $stepDetails[] = [
                    'step_id' => $step->sn,
                    'status' => $status,
                    'text' => $text,
                    'icon' => $step->icon ?? null,
                    'completed_at' => $completedAt,
                ] + ($remarks ? ['remarks' => $remarks] : []);
            }

            $service->steps = $stepDetails;
        }

        return $this->successResponse([
            'active_services' => $services,
        ]);
    } catch (\Exception $e) {
        return $this->errorResponse($e->getMessage(), 500);
    }
}

 public function completedServices(Request $request)
{
    try {
        $user = auth()->user();

        // Fetch only completed services (grouped by order_id + microservice_id)
        $services = DB::table('user_services as us')
            ->join('microservice as ms', 'us.microservice_id', '=', 'ms.sn')
            ->leftJoin('service_steps as fs', function ($join) {
                $join->on('fs.microservice_id', '=', 'us.microservice_id')
                     ->where('fs.step_order', '=', 1);
            })
            ->leftJoin('orders as o', 'us.order_id', '=', 'o.orderid')
            ->leftJoin('transactions as t', 't.orderid', '=', 'us.order_id')
            ->where('us.id', $user->id)
            ->where(function ($q) {
                $q->where('us.status', 2)
                  ->orWhere('o.all_steps_completed', 1);
            })
            ->select(
                DB::raw('MAX(us.sn) as user_step_id'), // latest record
                'us.microservice_id',
                'us.order_id',
                'ms.category as service_name',
                'ms.days',
                'ms.microsite',
                'ms.heading',
                'ms.persons_image',
                'ms.purchases',
                'ms.button',
                'fs.post_text as first_post_text',
                DB::raw('MAX(o.activate_date) as order_activate_date'),
                DB::raw('MAX(us.created_at) as created_at'),
                DB::raw('DATEDIFF(MAX(o.expiry_date), NOW()) as days_left'),
                DB::raw('MAX(t.totalAmount) as transaction_amount'),
                DB::raw('MAX(t.paymentMode) as paymentMode')
            )
            ->groupBy(
                'us.microservice_id',
                'us.order_id',
                'ms.category',
                'ms.days',
                'ms.microsite',
                'ms.heading',
                'ms.persons_image',
                'ms.purchases',
                'ms.button',
                'fs.post_text'
            )
            ->orderBy('created_at', 'desc')
            ->get();

        foreach ($services as $service) {
            // Decode persons_image if exist
            $service->persons_image = !empty($service->persons_image)
                ? json_decode($service->persons_image, true)
                : [];

            // Fetch all steps for this microservice
            $steps = DB::table('service_steps')
                ->where('microservice_id', $service->microservice_id)
                ->orderBy('step_order', 'asc')
                ->get();

            // Fetch the user's step records for this service
            $userStepRecords = DB::table('user_services')
                ->where('order_id', $service->order_id)
                ->where('microservice_id', $service->microservice_id)
                ->get()
                ->keyBy('current_step_id');

            $stepDetails = [];
            foreach ($steps as $step) {
                $status = 'not_started';
                $completedAt = null;

                if (isset($userStepRecords[$step->sn])) {
                    $record = $userStepRecords[$step->sn];
                    $status = $record->step_status;
                    if ($status === 'completed') {
                        $completedAt = $record->created_at;
                    }
                }

                $text = match ($status) {
                    'completed'   => $step->post_text,
                    'in_progress' => $step->inprogress_text,
                    default       => $step->pre_text,
                };

                $stepDetails[] = [
                    'step_id'      => $step->sn,
                    'status'       => $status,
                    'text'         => $text,
                    'icon'         => $step->icon ?? null,
                    'completed_at' => $completedAt,
                ];
            }

            $service->steps = $stepDetails;
        }

        return $this->successResponse([
            'completed_services' => $services,
        ]);
    } catch (\Exception $e) {
        return $this->errorResponse($e->getMessage(), 500);
    }
}




    public function serviceSteps(Request $request)
    {
        try {
            $user = auth()->user();
            // Get user_service and microservice info
            $userService = DB::table('user_services as us')
                ->join('microservice as ms', 'us.microservice_id', '=', 'ms.sn')
                ->where('us.id', $user->id)
                ->where('us.user_id', $user->id)
                ->select(
                    'us.*',
                    'ms.category',
                    'ms.heading',
                    'ms.days',
                    'ms.microsite',
                    'ms.main'
                )
                ->first();

            if (!$userService) {
                return response()->json(['error' => 'Service not found'], 404);
            }

            // Get all steps for this microservice
            $steps = DB::table('service_steps')
                ->where('microservice_id', $userService->microservice_id)
                ->where('status', 1)
                ->orderBy('step_order', 'asc')
                ->get();

            // Get transaction/order for this service
            $transaction = DB::table('transactions')
                ->where('feature_sn', $userService->microservice_id)
                ->where('id', $userService->user_id)
                ->first();

            // Format steps with done / in_progress / not_done
            $currentStepOrder = DB::table('service_steps')
                ->where('id', $userService->current_step_id)
                ->value('step_order') ?? 1;

            $formattedSteps = $steps->map(function ($step) use ($currentStepOrder) {
                $status = 'not_done';
                if ($step->step_order < $currentStepOrder) {
                    $status = 'done';
                } elseif ($step->step_order == $currentStepOrder) {
                    $status = 'in_progress';
                }
                return [
                    'id'              => $step->id,
                    'step_order'      => $step->step_order,
                    'pre_text'        => $step->pre_text,
                    'inprogress_text' => $step->inprogress_text,
                    'post_text'       => $step->post_text,
                    'require_upload'  => $step->require_upload,
                    'require_approval'=> $step->require_approval,
                    'icon'            => $step->icon,
                    'status'          => $status,
                ];
            });

            return response()->json([
                'success' => true,
                'service' => [
                    'user_service_id' => $userService->id,
                    'microservice_id' => $userService->microservice_id,
                    'service_name'    => $userService->category,
                    'current_step_id' => $userService->current_step_id,
                    'steps'           => $formattedSteps,
                    'transaction'     => $transaction ? [
                        'orderid'        => $transaction->orderid,
                        'orderStatus'    => $transaction->orderStatus,
                        'paymentMode'    => $transaction->paymentMode,
                        'totalAmount'    => $transaction->totalAmount,
                        'currency'       => $transaction->currency,
                        'transactionDate'=> $transaction->transactionDate,
                    ] : null
                ]
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'error'   => 'Something went wrong',
                'message' => $e->getMessage()
            ], 500);
        }
    }


public function purchase(Request $request)
{
    $validator = Validator::make($request->all(), [
        'microservice_sn' => 'required|integer'
    ]);

    if ($validator->fails()) {
        return $this->errorResponse($validator->errors()->first(), 422);
    }


    $user = auth()->user();
    $userId = $user->id;
    $microserviceSn = $request->microservice_sn;

    DB::beginTransaction();

    try {
        // Fetch microservice
        $microservice = DB::table('microservice')->where('sn', $microserviceSn)->first();

        if (!$microservice) {
            return $this->errorResponse('Microservice not found', 404);
        }

        // Check if user already has active service
        $alreadyPurchased = DB::table('user_services as us')
            ->join('orders as o', 'us.order_id', '=', 'o.orderid')
            ->where('us.id', $userId)
            ->where('us.microservice_id', $microserviceSn)
            ->where('us.status', 1)
            ->where(function ($q) {
                $q->whereNull('o.expiry_date')->orWhere('o.expiry_date', '>', now());
            })
            ->first();

        if ($alreadyPurchased) {
            return $this->errorResponse(
                'Service already purchased and active',
                409,
                ['expiry_date' => $alreadyPurchased->expiry_date]
            );

        }

        $cost = $microservice->cost;
        $totalDays = $microservice->days;
        $activateDate = now();
        $expiryDate = Carbon::parse($activateDate)->addDays($totalDays);

        $api = new Api(env('RAZORPAY_KEY'), env('RAZORPAY_SECRET'));

        // Check for all pending orders for this user & microservice
       $pendingOrders = DB::table('orders')
    ->where('user_id', $userId)
    ->where('service_sn', $microserviceSn)
    ->where('payment_status', 'created')
    ->get(); // fetch all pending orders

if ($pendingOrders->isNotEmpty()) {
    $updatedOrders = [];

    foreach ($pendingOrders as $order) {
        // Create new Razorpay order for retry
        $razorpayOrder = $api->order->create([
            'receipt' => Str::uuid()->toString(),
            'amount' => $cost * 100,
            'currency' => 'INR',
            'payment_capture' => 1
        ]);

        $activateDate = now();
        $expiryDate = Carbon::parse($activateDate)->addDays($totalDays);

        // Update all relevant columns in orders
        DB::table('orders')->where('orderid', $order->orderid)->update([
            'total_amount' => $cost,
            'activate_date' => $activateDate,
            'expiry_date' => $expiryDate,
            'payment_status' => 'created',
            'all_steps_completed' => 0,
            'updated_at' => now()
        ]);

        // Update all relevant columns in transactions
        DB::table('transactions')->where('orderid', $order->orderid)->update([
            'totalAmount' => $cost,
            'payment_status' => 'created',
            'razorpay_order_id' => $razorpayOrder['id'],
            'transactionDate' => $activateDate,
            'status' => 0,
            'updated_at' => now()
        ]);

        // Update user_services for this order
        $firstStep = DB::table('service_steps')
            ->where('microservice_id', $microserviceSn)
            ->orderBy('step_order', 'asc')
            ->first();

        $firstStepId = $firstStep ? $firstStep->sn : null;

        DB::table('user_services')->updateOrInsert(
            ['id' => $userId, 'microservice_id' => $microserviceSn],
            [
                'current_step_id' => $firstStepId,
                'order_id' => $order->orderid,
                'step_status' => 'pending',
                'status' => 0,
                'updated_at' => now(),
                'created_at' => now()
            ]
        );

        $updatedOrders[] = [
            'order_id' => $order->orderid,
            'user_id' => $userId,
            'microservice_sn' => $microserviceSn,
            'total_amount' => $cost,
            'activate_date' => $activateDate,
            'expiry_date' => $expiryDate,
            'current_step_id' => $firstStepId,
            'razorpay_order_id' => $razorpayOrder['id']
        ];
    }

    DB::commit();

return $this->successResponse([
    'message' => 'Pending orders updated successfully',
    'orders'  => count($updatedOrders) === 1
        ? $updatedOrders[0]   // return single object
        : $updatedOrders      // return array
]);

}
        // No pending orders, create new
        $razorpayOrder = $api->order->create([
            'receipt' => Str::uuid()->toString(),
            'amount' => $cost * 100,
            'currency' => 'INR',
            'payment_capture' => 1
        ]);

        $orderId = DB::table('orders')->insertGetId([
            'user_id' => $userId,
            'service_sn' => $microserviceSn,
            'total_amount' => $cost,
            'order_date' => now(),
            'activate_date' => $activateDate,
            'expiry_date' => $expiryDate,
            'payment_status' => 'created',
            'all_steps_completed' => 0,
            'transaction_sn' => 'TXN' . rand(1000, 9999),
            'created_at' => now(),
            'updated_at' => now()
        ]);

        // Fetch first step
        $firstStep = DB::table('service_steps')
            ->where('microservice_id', $microserviceSn)
            ->orderBy('step_order', 'asc')
            ->first();

        $firstStepId = $firstStep ? $firstStep->sn : null;

        DB::table('user_services')->insert([
            'id' => $userId,
            'microservice_id' => $microserviceSn,
            'current_step_id' => $firstStepId,
            'order_id' => $orderId,
            'step_status' => 'pending',
            'status' => 0,
            'created_at' => now(),
            'updated_at' => now()
        ]);

        DB::table('transactions')->insert([
            'id' => $userId,
            'orderid' => $orderId,
            'payment_status' => 'created',
            'paymentMode' => 'Online',
            'currency' => 'INR',
            'totalAmount' => $cost,
            'transactionDate' => now(),
            'status' => 0,
            'razorpay_order_id' => $razorpayOrder['id'],
            'feature' => 'microservice',
            'feature_sn' => $microserviceSn,
            'sub_feature' => 'orders',
            'sub_feature_sn' => $orderId,
            'created_at' => now(),
            'updated_at' => now()
        ]);

        DB::commit();

        return $this->successResponse([
            'message' => 'Order created successfully',
            'order' => [
                'order_id' => $orderId,
                'user_id' => $userId,
                'microservice_sn' => $microserviceSn,
                'total_amount' => $cost,
                'current_step_id' => $firstStepId,
                'razorpay_order_id' => $razorpayOrder['id']
            ]
        ]);


    } catch (\Exception $e) {
        DB::rollBack();
        return $this->errorResponse('Something went wrong', 500, $e->getMessage());
    }

}


public function updateStep(Request $request)
{
    try {
        $request->validate([
           'microservice_id' => 'required|integer|exists:microservice,sn',
            'order_id' => 'required|integer|exists:orders,orderid',
            'step_id' => 'required|integer|exists:service_steps,sn',
            'link' => 'nullable|string',
        ]);

        $user = auth()->user();

        $userService = DB::table('user_services')
            ->where('microservice_id', $request->microservice_id)
            //->where('current_step_id',  $request->step_id)
			 ->where('id', $user->id)
            ->where('order_id', $request->order_id)
            ->first();

        if (!$userService) {
            return $this->errorResponse('Service not found', 404);


        }

        $order = DB::table('orders')
            ->where('orderid', $userService->order_id)
            ->where('payment_status', 'success')
            ->where(function($q) {
                $q->whereNull('expiry_date')
                  ->orWhere('expiry_date', '>', now());
            })
            ->first();

        if (!$order) {

            return $this->errorResponse('Order is not valid or has expired', 400);

        }

        $step = DB::table('service_steps')
            ->where('sn', $request->step_id)
            ->where('microservice_id', $userService->microservice_id)
            ->first();

            if (!$step) {
                return $this->errorResponse('Invalid step for this service', 400);
            }


        $newStatus = $step->require_approval ? 'in_progress' : 'completed';

        $insertData = [
			'id'=>$user->id,
			'microservice_id'=>$request->microservice_id,

			'order_id'=>$request->order_id,
            'current_step_id' => $request->step_id,
            'step_status' => $newStatus,
            'remarks' => $request->remarks,
            'created_at' => now(),
        ];

if ($step->require_upload != 1) {

	return $this->errorResponse([
    'message' => 'No action required from your side.',

]);
}



        if ($step->require_upload == 1 && $request->hasFile('link')) {

            $insertData['link'] = $request->file('link');
        }



        DB::beginTransaction();

        // Update user_services
         DB::table('user_services')->insert($insertData);

        // Check if this is the last step
        $lastStep = DB::table('service_steps')
            ->where('microservice_id', $userService->microservice_id)
            ->orderBy('step_order', 'desc')
            ->first();

        if ($lastStep && $request->step_id == $lastStep->sn) {
            // Mark order as completed
            DB::table('orders')
                ->where('orderid', $userService->order_id)
                ->update(['all_steps_completed' => 1, 'updated_at' => now()]);


        }

        DB::commit();

        return $this->successResponse([
            'step_id' => $request->step_id,
            'status'  => $newStatus,
            'link'    => $updateData['link'] ?? null,
            'ans'     => $updateData['ans'] ?? null,
        ], 'Step updated successfully');

        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse('Failed to update step', 500, $e->getMessage());
        }

}


public function verifyPayment(Request $request)
{
    $request->validate([
        'razorpay_payment_id' => 'required|string',
        'razorpay_order_id' => 'required|string',
        'razorpay_signature' => 'required|string',
        'order_id' => 'required|integer|exists:orders,orderid'
    ]);

    try {
        $orderId = $request->order_id;
        $razorpayPaymentId = $request->razorpay_payment_id;
        $razorpayOrderId = $request->razorpay_order_id;
        $razorpaySignature = $request->razorpay_signature;

        $order = DB::table('orders')->where('orderid', $orderId)->first();
        if (!$order) {
            return $this->errorResponse('Order not found', 404);
        }

       $api = new Api (env('RAZORPAY_KEY'), env('RAZORPAY_SECRET'));
$payment = $api->payment->fetch($razorpayPaymentId);

$paymentMode = $payment->method;
		$transactionDate = \Carbon\Carbon::createFromTimestamp($payment->created_at);
		 $userId = auth()->user()->id;
        // Verify signature
        $attributes = [
            'razorpay_order_id' => $razorpayOrderId,
            'razorpay_payment_id' => $razorpayPaymentId,
            'razorpay_signature' => $razorpaySignature
        ];

        DB::beginTransaction();

        try {
            $api->utility->verifyPaymentSignature($attributes);

            // Payment successful
            DB::table('orders')->where('orderid', $orderId)->update([
                'payment_status' => 'success',
                'activate_date' => now(),
                'expiry_date' => now()->addDays($order->days ?? 30),
                'updated_at' => now()
            ]);

          DB::table('transactions')
    ->updateOrInsert(
        [
              'orderid' => $orderId,
            'razorpay_order_id' => $razorpayOrderId,
			'id'=>$userId
        ],
        [
            'payment_status' => 'success',
            'paymentMode' => $paymentMode,
            'currency' => 'INR',
            'totalAmount' => $order->total_amount,
            'transactionDate' => $transactionDate,
            'status' => 1,
            'razorpay_payment_id' => $razorpayPaymentId,
            'razorpay_signature' => $razorpaySignature,
            'feature' => 'microservice',
            'feature_sn' => $order->service_sn,
            'sub_feature' => 'orders',
            'sub_feature_sn' => $orderId,
            'updated_at' => now(),
            'created_at' => now()  // used only if inserting
        ]
    );

            DB::commit();

            return $this->successResponse([
                'message' => 'Payment verified successfully',
            ]);

        } catch (\Razorpay\Api\Errors\SignatureVerificationError $e) {
            // Payment failed: insert failed transaction
            DB::table('orders')->where('orderid', $orderId)->update([
                'payment_status' => 'failed',
                'updated_at' => now()
            ]);

           DB::table('transactions')
    ->updateOrInsert(
        [
            'orderid' => $orderId,
            'razorpay_order_id' => $razorpayOrderId,
			'id'=>$userId
        ],
        [
            'payment_status' => 'failed',
            'paymentMode' => $paymentMode,
            'currency' => 'INR',
            'totalAmount' => $order->total_amount,
             'transactionDate' => $transactionDate,
            'status' => 0,
             'razorpay_payment_id' => $razorpayPaymentId,
            'razorpay_signature' => $razorpaySignature,
            'feature' => 'microservice',
            'feature_sn' => $order->service_sn,
            'sub_feature' => 'orders',
            'sub_feature_sn' => $orderId,
            'updated_at' => now(),
            'created_at' => now()
        ]
    );

            DB::commit();

            return $this->errorResponse('Invalid signature: ' . $e->getMessage(), 400);
        }

    } catch (\Exception $e) {
        DB::rollBack();
        return $this->errorResponse('Payment verification failed: ' . $e->getMessage(), 500);
    }
}


}
