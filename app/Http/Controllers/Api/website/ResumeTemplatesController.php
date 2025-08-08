<?php

namespace App\Http\Controllers\Api\website;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
    use Illuminate\Support\Facades\DB;
    use Illuminate\Support\Facades\Validator;
use App\Traits\ApiResponseTrait;

class ResumeTemplatesController extends Controller
{

    use ApiResponseTrait;
    public function templatesCategory(Request $request)
    {
        try {
            // Validate the input
            $validator = Validator::make($request->all(), [
                'category' => 'required|string|max:100',
            ]);

            if ($validator->fails()) {
                return $this->errorResponse($validator->errors()->first(), 422);
            }

            $category = $request->input('category');

            $categories = DB::table('resource_profile_design_categories')
            ->select('id', 'title', 'description', 'image', 'icon', 'link')
            ->where('status', 1)
            ->orderBy('created_at', 'desc')
           ->limit(5)
            ->get();




            $faqs = DB::table('resource_faqs')
                ->select('sn', 'question', 'answer',  'created_at')
                ->where([
                    ['category', '=', $category],
                    ['status', '=', 1],
                ])
                ->orderBy('created_at', 'desc')
                ->limit(5)
                ->get();

                $designs = DB::table('resource-profiledesign')
                ->select('design_image')
                ->where('status', 1)
                ->orderBy('downloadTimes', 'desc')
                ->limit(5)
                ->get();

                $testimonials = DB::table('resource_testimonials')
                ->select('sn', 'title', 'description', 'role', 'rating', 'source', 'created_at')
                ->where([
                    ['category', '=', $category],
                    ['status', '=', 1],
                ])
                ->orderBy('created_at', 'desc')
                ->limit(5)
                ->get();
            return $this->successResponse([
                'categories' => $categories,
                'designs'         => $designs,

                'testimonials' => $testimonials,
                'faqs'         => $faqs,

            ], 'All Data Fetched!!');

        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong! ' . $e->getMessage(), 500);
        }
    }

    public function getDesignsByCategory(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'category' => 'required|string|max:100',
                'category_id' => 'required|string|max:100',
            ]);

            if ($validator->fails()) {
                return $this->errorResponse($validator->errors()->first(), 422);
            }
            $category = $request->input('category');
            $categoryId = $request->input('category_id');

            $designs = DB::table('resource-profiledesign')
                ->where('status', 1)
                ->where('categoryid', $categoryId)
                ->orderBy('downloadTimes', 'desc')
                ->limit(9)

                ->get();
            $testimonials = DB::table('resource_testimonials')
                ->select('sn', 'title', 'description', 'role', 'rating', 'source', 'created_at')
                ->where([
                    ['category', '=', $category],
                    ['sub_category', '=', $categoryId],
                    ['status', '=', 1],
                ])
                ->orderBy('created_at', 'desc')
                ->limit(5)
                ->get();

                $faqs = DB::table('resource_faqs')
                ->select('sn', 'question', 'answer',  'created_at')
                ->where([
                    ['category', '=', $category],
                    ['sub_category', '=', $categoryId],

                    ['status', '=', 1],
                ])
                ->orderBy('created_at', 'desc')
                ->limit(5)
                ->get();
                return $this->successResponse([
                    'designs'         => $designs,

                    'testimonials' => $testimonials,
                    'faqs'         => $faqs,

                ], 'All Data Fetched!!');

        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong! ' . $e->getMessage(), 500);
        }
    }
}
