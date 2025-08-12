<?php

namespace App\Http\Controllers\Api\website;


use App\Http\Controllers\Controller;
use App\Traits\ApiResponseTrait;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class PromotionController extends Controller
{
    use ApiResponseTrait;

    public function promotion(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'category' => 'required|string|max:100',
            ]);

            if ($validator->fails()) {
                return $this->errorResponse($validator->errors()->first(), 422);
            }
            $category = $request->input('category') ?? 'services';



            $testimonials = DB::table('resource_testimonials')
                ->select('sn', 'title', 'description', 'role', 'rating', 'source', 'created_at')
                ->where([
                    ['category', '=', $category],
                    ['status', '=', 1],
                ])
                ->orderBy('created_at', 'desc')
                ->limit(5)
                ->get();

            $faqs = DB::table('resource_faqs')
                ->select('sn', 'question', 'answer', 'created_at','category', 'sub_category')
                ->where([
                    ['category', '=', $category],

                    ['status', '=', 1],
                ])
                ->orderBy('created_at', 'desc')
                ->limit(5)
                ->get();

            return $this->successResponse([
                'testimonials' => $testimonials,
                'faqs'         => $faqs,
            ], 'All Services Fetched!!');

        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong! ' . $e->getMessage(), 500);
        }
    }
}
