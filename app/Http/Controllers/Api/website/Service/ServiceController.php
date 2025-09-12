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

            $services = DB::table('user_services as us')
            ->join('microservice as ms', 'us.microservice_id', '=', 'ms.sn')

            // current step (user progress)
            ->leftJoin('service_steps as ss', 'us.current_step_id', '=', 'ss.id')

            // first step (step_order = 1)
            ->leftJoin('service_steps as fs', function ($join) {
                $join->on('fs.microservice_id', '=', 'us.microservice_id')
                     ->where('fs.step_order', '=', 1);
            })

            // transaction join
            ->leftJoin('transactions as t', function ($join) {
                $join->on('t.platformid', '=', 'us.user_id')
                     ->on('t.feature_sn', '=', 'us.microservice_id');
            })

            ->where('us.user_id', $user->id)
            ->where('us.status', 1) // active
            ->where(function ($q) {
                $q->whereNull('us.expiry_date')
                  ->orWhere('us.expiry_date', '>=', now());
            })

            ->select(
                'us.id as user_service_id',
                'us.microservice_id',
                'us.current_step_id',
                'us.activation_date',
                'us.expiry_date',
                'us.status as service_status',

                'ms.category as service_name',
                'ms.days',
                'ms.microsite',
                'ms.heading',
                'ms.main',

                // current step details
                'ss.id as current_step_id',
                'ss.pre_text as current_pre_text',
                'ss.inprogress_text as current_inprogress_text',
                'ss.post_text as current_post_text',

                // first step details
                'fs.id as first_step_id',
                'fs.pre_text as first_pre_text',
                'fs.inprogress_text as first_inprogress_text',
                'fs.post_text as first_post_text',

                // transaction
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
