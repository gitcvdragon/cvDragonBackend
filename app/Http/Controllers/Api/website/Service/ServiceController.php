<?php

namespace App\Http\Controllers\Api\website\Service;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Tymon\JWTAuth\Facades\JWTAuth;
use Razorpay\Api\Api;

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
                ->where('platformid', $userService->user_id)
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
                ->where('platformid', $userService->user_id)
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

public function subscribeService(Request $request)
{
    try {
        $request->validate([
            'microservice_id' => 'required|integer|exists:microservice,sn',
        ]);

        $user = auth()->user();
        $microserviceId = $request->microservice_id;

        $existing = DB::table('user_services')
            ->where('user_id', $user->id)
            ->where('microservice_id', $microserviceId)
            ->where('status', 1) // active
            ->first();

        if ($existing) {
            $transaction = DB::table('transactions')
                ->where('id', $user->id)
                ->where('feature', 'service_subscription')
                ->where('feature_sn', $microserviceId)
                ->first();

            if ($transaction) {
                if ($transaction->orderStatus === 'Success') {
                    // Already paid → reject
                    return response()->json([
                        'success' => false,
                        'message' => 'Already subscribed and payment successful'
                    ], 400);
                }

                if ($transaction->orderStatus === 'Created') {
                    // Retry: re-create Razorpay order
                    $microservice = DB::table('microservice')->where('sn', $microserviceId)->first();
                    $amountInRupees = $microservice->cost ?? 0;
                    $amount = $amountInRupees * 100;
                    $currency = "INR";

                    $api = new Api(env('RAZORPAY_KEY'), env('RAZORPAY_SECRET'));
                    $razorpayOrder = $api->order->create([
                        'receipt'         => 'order_rcpt_' . $existing->id,
                        'amount'          => $amount,
                        'currency'        => $currency,
                        'payment_capture' => 1
                    ]);

                    // Update transaction with new order id
                    DB::table('transactions')->where('id', $transaction->id)->update([
                        'orderid'     => $razorpayOrder['id'],
                        'updated_at'  => now(),
                        'orderStatus' => 'Created',
                    ]);

                    return response()->json([
                        'success' => true,
                        'message' => 'Payment pending, new order created. Please complete payment.',
                        'user_service_id' => $existing->id,
                        'razorpay_order'  => $razorpayOrder,
                        'amount'          => $amountInRupees,
                        'currency'        => $currency,
                        'service_name'    => $microservice->heading ?? $microservice->category
                    ]);
                }
            }
        }

        // -------------------------
        // NEW SUBSCRIPTION
        // -------------------------

        // Fetch microservice info (with cost)
        $microservice = DB::table('microservice')->where('sn', $microserviceId)->first();
        if (!$microservice) {
            return response()->json(['success' => false, 'message' => 'Microservice not found'], 404);
        }

        $amountInRupees = $microservice->cost ?? 0;
        $amount = $amountInRupees * 100;
        $currency = "INR";

        // Get first step
        $firstStep = DB::table('service_steps')
            ->where('microservice_id', $microserviceId)
            ->where('status', 1)
            ->orderBy('step_order', 'asc')
            ->first();

        if (!$firstStep) {
            return response()->json(['success' => false, 'message' => 'No steps found for this service'], 404);
        }

        // Insert user_services
        $userServiceId = DB::table('user_services')->insertGetId([
            'user_id'          => $user->id,
            'microservice_id'  => $microserviceId,
            'current_step_id'  => $firstStep->id,
            'activation_date'  => now(),
            'expiry_date'      => null,
            'status'           => 1, // active
            'created_at'       => now(),
            'updated_at'       => now(),
        ]);

             $api = new Api(env('RAZORPAY_KEY'), env('RAZORPAY_SECRET'));
             $razorpayOrder = $api->order->create([
                 'receipt'         => 'order_rcpt_' . $userServiceId,
                 'amount'          => $amount,
                 'currency'        => $currency,
                 'payment_capture' => 1
             ]);

$razorpayOrder = $razorpayOrder->toArray();

        // Insert transaction with Created status
        DB::table('transactions')->insert([
            'id'  => $user->id,
            'feature'         => 'service_subscription',
            'feature_sn'      => $microserviceId,
            'orderid'         => $razorpayOrder['id'],
            'orderStatus'     => 'Created',
            'paymentMode'     => 'Razorpay',
            'totalAmount'     => $amountInRupees,
            'currency'        => $currency,
            'transactionDate' => now(),
            'status'          => 1, // pending
            'created_at'      => now(),
            'updated_at'      => now(),
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Service subscription initiated',
            'user_service_id' => $userServiceId,
            'razorpay_order'  => $razorpayOrder,
            'amount'          => $amountInRupees,
            'currency'        => $currency,
            'service_name'    => $microservice->heading ?? $microservice->category
        ]);

    } catch (\Exception $e) {
        return response()->json([
            'success' => false,
            'error'   => 'Failed to subscribe service',
            'message' => $e->getMessage()
        ], 500);
    }
}
public function updateStep(Request $request, $userServiceId)
{
    try {
        $request->validate([
            'step_id' => 'required|integer|exists:service_steps,id',
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

        // Verify step belongs to this service
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

        // Decide status based on require_approval
        $newStatus = $step->require_approval ? 'in_progress' : 'done';

        // Update current step + status
        DB::table('user_services')
            ->where('id', $userServiceId)
            ->update([
                'current_step_id' => $request->step_id,
                'status'          => $newStatus,
                'updated_at'      => now(),
            ]);

        return response()->json([
            'success' => true,
            'message' => 'Step updated successfully',
            'step_id' => $request->step_id,
            'status'  => $newStatus
        ]);

    } catch (\Exception $e) {
        return response()->json([
            'success' => false,
            'error'   => 'Failed to update step',
            'message' => $e->getMessage()
        ], 500);
    }
}


}
