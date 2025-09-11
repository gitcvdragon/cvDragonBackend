<?php

namespace App\Http\Controllers\Api\website\Subscription;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\CreateCvuserprofile;
use App\Models\CvProfileSection;
use App\Traits\ApiResponseTrait;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

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


}
