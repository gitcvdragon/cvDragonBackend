<?php

namespace App\Http\Controllers\Api\Admin\Subscription;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class SubscriptionController extends Controller
{
    /**
     * List all subscriptions with limit & offset
     */
    public function listSubscriptions(Request $request)
    {
        $limit  = $request->get('limit', 10);
        $offset = $request->get('offset', 0);

        try {
            $subscriptions = DB::table('user-subscription as us')
                ->join('user-basic as ub', 'us.user_id', '=', 'ub.id')
                ->leftJoin('resource-profiledesign as rd', 'us.design', '=', 'rd.designid')
                ->select(
                    'us.sn',
                    'us.design',
                    'ub.fullName as userName',
                    'ub.profileImageUrl as userimg',
                    'rd.designName',
                    'rd.content',
                    'us.activate as startDate',
                    'us.expiry as endDate',
                    'us.status'
                )
                ->where('us.status', 1)
                ->offset($offset)
                ->limit($limit)
                ->orderByDesc('us.dateCreated')
                ->get()
                ->map(function ($sub) {
                    // Handle Pro subscription
                    if ($sub->design == 0) {
                        $subscriptionLine1 = 'Pro Subscription';
                        $subscriptionLine2 = null;
                    } else {
                        $subscriptionLine1 = $sub->designName;
                        $subscriptionLine2 = $sub->content;
                    }

                    return [
                        'userName' => $sub->userName,
                        'userimg' => $sub->userimg ?? '/assets/avatar.png',
                        'subscriptionLine1' => $subscriptionLine1,
                        'subscriptionLine2' => $subscriptionLine2,
                        'startDate' => $sub->startDate,
                        'endDate' => $sub->endDate,
                        'actionIcons' => [
                            ['src' => '/assets/pencil-edit.svg', 'permission' => true],
                            ['src' => '/assets/delete-icon.svg', 'permission' => true],
                            ['src' => '/assets/download-left.svg', 'permission' => true],
                        ]
                    ];
                });

            return response()->json([
                'subscriptions' => $subscriptions
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Something went wrong: ' . $e->getMessage()
            ], 500);
        }
    }



    /**
     * Get single subscription details
     */
    public function subscriptionDetail($id)
    {
        try {
            $subscription = DB::table('user-subscription as us')
                ->join('user-basic as ub', 'us.user_id', '=', 'ub.id')
                ->leftJoin('resource-profiledesign as rd', 'us.design', '=', 'rd.designid')
                ->select(
                    'us.sn',
                    'us.design',
                    'ub.fullName as userName',
                    'rd.designName',
                    'rd.content',
                    'us.activate as startDate',
                    'us.expiry as endDate',
                    'us.securityKey',
                    'us.status'
                )
                ->where('us.sn', $id)
                ->first();

            if (!$subscription) {
                return response()->json(['error' => 'Subscription not found'], 404);
            }

            // Handle Pro subscription
            if ($subscription->design == 0) {
                $subscription->subscriptionLine1 = 'Pro Subscription';
                $subscription->subscriptionLine2 = null;
            } else {
                $subscription->subscriptionLine1 = $subscription->designName;
                $subscription->subscriptionLine2 = $subscription->content;
            }

            // Remove raw designName/content to avoid confusion
            unset($subscription->designName, $subscription->content);

            return response()->json($subscription, 200);

        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Something went wrong: ' . $e->getMessage()
            ], 500);
        }
    }


    /**
     * Update subscription
     */
    public function updateSubscription(Request $request, $id)
    {
        $data = $request->only(['design', 'activate', 'expiry', 'status']);

        try {
            $updated = DB::table('user-subscription')
                ->where('sn', $id)
                ->update($data);

            if ($updated) {
                return response()->json([
                    'success' => true,
                    'message' => 'Subscription updated successfully'
                ], 200);
            } else {
                return response()->json([
                    'success' => false,
                    'message' => 'No changes made or subscription not found'
                ], 404);
            }
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Something went wrong!',
                'error'   => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Soft delete subscription (set status = 0)
     */
    public function softDeleteSubscription($id)
    {
        try {
            $subscription = DB::table('user-subscription')
                ->where('sn', $id)
                ->where('status', 1)
                ->first();

            if (!$subscription) {
                return response()->json([
                    'success' => false,
                    'message' => 'Subscription not found or already deleted'
                ], 404);
            }

            DB::table('user-subscription')
                ->where('sn', $id)
                ->update(['status' => 0]);

            return response()->json([
                'success' => true,
                'message' => 'Subscription soft deleted successfully'
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Something went wrong!',
                'error'   => $e->getMessage()
            ], 500);
        }
    }
}
