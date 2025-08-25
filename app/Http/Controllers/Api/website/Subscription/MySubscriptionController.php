<?php

namespace App\Http\Controllers\Api\website\Subscription;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\CreateCvuserprofile;
use App\Models\CvProfileSection;
use App\Traits\ApiResponseTrait;
use Illuminate\Support\Facades\DB;

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

        $design = DB::table('resource-profiledesign')
        ->select('designName','categoryid')
            ->where('designid', $subscription->design)
            ->where('status', 1)
            ->first();

        if ($design) {
            // Decode sectionOrder JSON

            // Fetch design category
            $category = DB::table('resource_profile_design_categories')
            ->select('title')
                ->where('id', $design->categoryid)
                ->where('status', 1)
                ->first();

                $design->category = $category ? $category->title : null;
        }

        $subscription->designDetails = $design;
        return $subscription;
    });

    return $this->successResponse([
        'subscriptions' => $subscriptions
    ], 'All active subscriptions fetched successfully!');
}

}
