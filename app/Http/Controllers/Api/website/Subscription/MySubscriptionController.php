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
        ->where('user_id', $userId)
        ->where('status', 1)
        ->where('expiry', '>=', now())
        ->get();

    if ($subscriptions->isEmpty()) {
        return $this->errorResponse('No active subscriptions found.', 404);
    }

    // Loop through each subscription and attach design + category
    $subscriptions->transform(function ($subscription) {
        $design = DB::table('resource-profiledesign')
            ->where('designid', $subscription->design)
            ->where('status', 1)
            ->first();

        if ($design) {
            // Decode sectionOrder JSON
            $design->sectionOrder = !empty($design->sectionOrder)
                ? json_decode($design->sectionOrder, true)
                : [];

            // Fetch design category
            $category = DB::table('resource_profile_design_categories')
                ->where('id', $design->categoryid)
                ->where('status', 1)
                ->first();

            $design->category = $category;
        }

        $subscription->designDetails = $design;
        return $subscription;
    });

    return $this->successResponse([
        'subscriptions' => $subscriptions
    ], 'All active subscriptions with designs fetched successfully!');
}

}
