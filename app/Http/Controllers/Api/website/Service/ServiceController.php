<?php

namespace App\Http\Controllers\Api\website\Service;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Tymon\JWTAuth\Facades\JWTAuth;

class ServiceController extends Controller
{
    /**
     * Get all active services for the logged-in user
     */
    public function activeServices(Request $request)
    {
        try {

            $user = auth()->user();

            // 🔍 Fetch active services
            $services = DB::table('user_services as us')
                ->join('microservice as ms', 'us.microservice_id', '=', 'ms.sn')
                ->leftJoin('service_steps as ss', 'us.current_step_id', '=', 'ss.id')
                ->leftJoin('transactions as t', function ($join) {
                    $join->on('t.id', '=', 'us.user_id')
                         ->on('t.feature_sn', '=', 'us.microservice_id');
                })
                ->where('us.user_id', $user->id)
                ->where('us.status', 1) // 1 = active
                ->select(
                    'us.id as user_service_id',
                    'us.microservice_id',
                    'us.current_step_id',
                    'us.status as service_status',
                    'ms.category as service_name',
                    'ss.pre_text',
                    'ss.inprogress_text',
                    'ss.post_text',
                    't.orderid',
                    't.orderStatus',
                    't.paymentMode',
                    't.totalAmount',
                    't.currency',
                    't.transactionDate'
                )
                ->orderBy('us.created_at', 'desc')
                ->get();

            return response()->json([
                'success' => true,
                'active_services' => $services
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Something went wrong',
                'message' => $e->getMessage()
            ], 500);
        }
    }
}
