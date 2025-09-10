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
                ->join('resource-profiledesign as rd', 'us.design', '=', 'rd.designid')
                ->select(
                    'us.id',

                    'ub.fullName as userName',
                    'ub.profileImageUrl as userimg',
                    'rd.designName as subscriptionLine1',
                    'rd.content as subscriptionLine2',
                    'us.activate as startDate',
                    'us.expiry as endDate',
                    'us.status'
                )
                ->where('us.status', 1)
                ->offset($offset)
                ->limit($limit)
                ->orderByDesc('us.dateCreated')
                ->get()
                ->map(function($sub) {
                    return [
                        'userName' => $sub->userName,
                        'userimg' => $sub->userimg ?? '/assets/avatar.png',
                        'subscriptionLine1' => $sub->subscriptionLine1,
                        'subscriptionLine2' => $sub->subscriptionLine2,
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
                ->select(
                    'us.id',
                    'ub.fullName as userName',
                    'us.design as subscriptionLabel',
                    'rd.content as subscriptionLine2',

                    'us.activate as startDate',
                    'us.expiry as endDate',
                    'us.securityKey',
                    'us.status'
                )
                ->where('us.id', $id)
                ->first();

            if (!$subscription) {
                return response()->json(['error' => 'Subscription not found'], 404);
            }

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
                ->where('id', $id)
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
                ->where('id', $id)
                ->where('status', 1)
                ->first();

            if (!$subscription) {
                return response()->json([
                    'success' => false,
                    'message' => 'Subscription not found or already deleted'
                ], 404);
            }

            DB::table('user-subscription')
                ->where('id', $id)
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
