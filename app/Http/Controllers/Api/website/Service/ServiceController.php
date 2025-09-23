<?php

namespace App\Http\Controllers\Api\website\Service;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Tymon\JWTAuth\Facades\JWTAuth;
use Razorpay\Api\Api;
use Illuminate\Support\Str;

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
                $join->on('t.id', '=', 'us.user_id')
                     ->on('t.feature_sn', '=', 'us.microservice_id');
            })

            ->where('us.user_id', $user->id)
            ->where('us.status', 1)
            // ->where(function ($q) {
            //     $q->whereNull('us.expiry_date')
            //       ->orWhere('us.expiry_date', '>=', now());
            // })

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
                // 't.orderid',
                // 't.orderStatus',
                // 't.paymentMode',
                // 't.totalAmount',
                // 't.currency',
                // 't.transactionDate'
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
                ->value('step_order') ?? 1; // fallback to 1 if NULL

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

    public function completedServices(Request $request)
{
    try {
        $user = auth()->user();

        // Fetch all completed services for this user
        $services = DB::table('user_services as us')
            ->join('microservice as ms', 'us.microservice_id', '=', 'ms.sn')
            ->where('us.user_id', $user->id)
            ->where(function ($q) {
                $q->where('us.status', 0) // inactive
                  ->orWhere('us.expiry_date', '<', now()); // expired
            })
            ->select(
                'us.*',
                'ms.category',
                'ms.heading',
                'ms.days',
                'ms.microsite',
                'ms.main'
            )
            ->orderBy('us.expiry_date', 'desc')
            ->get();

        // Format each service with all steps + transaction details
        $result = $services->map(function ($userService) {
            // all steps
            $steps = DB::table('service_steps')
                ->where('microservice_id', $userService->microservice_id)
                ->where('status', 1)
                ->orderBy('step_order', 'asc')
                ->get();

            $currentStepOrder = DB::table('service_steps')
                ->where('id', $userService->current_step_id)
                ->value('step_order') ?? (count($steps) > 0 ? max($steps->pluck('step_order')->toArray()) : 1);

            $formattedSteps = $steps->map(function ($step) use ($currentStepOrder) {
                $status = 'not_done';
                if ($step->step_order < $currentStepOrder) {
                    $status = 'done';
                } elseif ($step->step_order == $currentStepOrder) {
                    $status = 'in_progress';
                } elseif ($step->step_order <= $currentStepOrder) {
                    $status = 'done';
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

            // transaction
            $transaction = DB::table('transactions')
                ->where('feature_sn', $userService->microservice_id)
                ->where('id', $userService->user_id)
                ->first();

            return [
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
            ];
        });

        return response()->json([
            'success' => true,
            'completed_services' => $result
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
    $request->validate([
        'user_id' => 'required|integer',
        'microservice_sn' => 'required|integer'
    ]);

    $user = auth()->user();
    $userId = $user->id;
    $microserviceSn = $request->microservice_sn;

    DB::beginTransaction();

    try {
        $microservice = DB::table('microservice')
            ->where('sn', $microserviceSn)
            ->first();

        if (!$microservice) {
            return response()->json(['error' => 'Microservice not found'], 404);
        }

        $cost = $microservice->cost;

        $api = new Api(config('services.razorpay.key'), config('services.razorpay.secret'));
        $razorpayOrder = $api->order->create([
            'receipt' => Str::uuid()->toString(),
            'amount' => $cost * 100, // paise
            'currency' => 'INR',
            'payment_capture' => 1
        ]);

        $orderId = DB::table('orders')->insertGetId([
            'user_id' => $userId,
            'service_sn' => $microserviceSn,
            'total_amount' => $cost,
            'order_date' => now(),
            'activate_date' => now(),
            'payment_status' => 'created',
            'all_steps_completed' => 0,
            'transaction_sn' => 'TXN' . rand(1000,9999),
            'created_at' => now(),
            'updated_at' => now()
        ]);

        $firstStep = DB::table('service_steps')
            ->where('microservice_id', $microserviceSn)
            ->orderBy('step_order', 'asc')
            ->first();

        $firstStepId = $firstStep ? $firstStep->id : null;

        DB::table('user_services')->insert([
            'user_id' => $userId,
            'microservice_id' => $microserviceSn,
            'current_step_id' => $firstStepId,
            'order_id' => $orderId,
            'step_status' => 'completed',
            'status' => 1,
            'created_at' => now(),
            'updated_at' => now()
        ]);

        DB::table('transactions')->insert([
            'orderid' => $orderId,
            'payment_status' => 'created',
            'paymentMode' => 'Online',
            'currency' => 'INR',
            'totalAmount' => $cost,
            'transactionDate' => now(),
            'status' => 1,
            'razorpay_order_id' => $razorpayOrder['id'],
            'feature' => 'microservice',
            'feature_sn' => $microserviceSn,
            'sub_feature' => 'orders',
            'sub_feature_sn' => $orderId,
            'created_at' => now(),
            'updated_at' => now()
        ]);

        DB::commit();

        return response()->json([
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
        return response()->json(['error' => 'Something went wrong', 'details' => $e->getMessage()], 500);
    }
}

public function updateStep(Request $request, $userServiceId)
{
    try {
        $request->validate([
            'step_id' => 'required|integer|exists:service_steps,id',
            'link' => 'nullable|string',
            'qn' => 'nullable|string|max:500',
            'remarks' => 'nullable|string|max:500'
        ]);

        $user = auth()->user();

        $userService = DB::table('user_services')
            ->where('id', $userServiceId)
            ->where('user_id', $user->id)
            ->first();

        if (!$userService) {
            return response()->json([
                'success' => false,
                'message' => 'Service not found'
            ], 404);
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
            return response()->json([
                'success' => false,
                'message' => 'Order is not valid or has expired'
            ], 403);
        }

        $step = DB::table('service_steps')
            ->where('id', $request->step_id)
            ->where('microservice_id', $userService->microservice_id)
            ->first();

        if (!$step) {
            return response()->json([
                'success' => false,
                'message' => 'Invalid step for this service'
            ], 400);
        }

        $newStatus = $step->require_approval ? 'in_progress' : 'completed';

        $updateData = [
            'current_step_id' => $request->step_id,
            'step_status' => $newStatus,
            'remarks' => $request->remarks,
            'created_at' => now(),
        ];

        if ($step->require_upload == 1 && $request->hasFile('link')) {

            $updateData['link'] = $request->file('link');
        }

        // Case 2: is_faq
        if (isset($step->is_faq) && $step->is_faq == 1 && $request->ans) {
            $updateData['qn'] = $request->qn;
        }

        DB::beginTransaction();

        // Update user_services
        DB::table('user_services')
            ->where('id', $userServiceId)
            ->update($updateData);

        // Check if this is the last step
        $lastStep = DB::table('service_steps')
            ->where('microservice_id', $userService->microservice_id)
            ->orderBy('step_order', 'desc')
            ->first();

        if ($lastStep && $request->step_id == $lastStep->id) {
            // Mark order as completed
            DB::table('orders')
                ->where('orderid', $userService->order_id)
                ->update(['all_steps_completed' => 1, 'updated_at' => now()]);

            // Mark user_services status as completed
            // DB::table('user_services')
            //     ->where('id', $userServiceId)
            //     ->update(['status' => 2]); // 2 = completed
        }

        DB::commit();

        return response()->json([
            'success' => true,
            'message' => 'Step updated successfully',
            'step_id' => $request->step_id,
            'status' => $newStatus,
            'link' => $updateData['link'] ?? null,
            'ans' => $updateData['ans'] ?? null
        ]);

    } catch (\Exception $e) {
        DB::rollBack();
        return response()->json([
            'success' => false,
            'error' => 'Failed to update step',
            'message' => $e->getMessage()
        ], 500);
    }
}


}
