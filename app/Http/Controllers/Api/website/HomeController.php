<?php

namespace App\Http\Controllers\Api\website;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
    use Illuminate\Support\Facades\DB;
    use Illuminate\Support\Facades\Validator;
use App\Traits\ApiResponseTrait;

class HomeController extends Controller
{


    public function fetchMarketingResources(Request $request)
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

            // Fetch data from resource_testimonials
            $testimonials = DB::table('resource_testimonials')
                ->select('sn', 'title', 'description', 'role', 'rating', 'source', 'created_at')
                ->where([
                    ['category', '=', $category],
                    ['status', '=', 1],
                ])
                ->orderBy('created_at', 'desc')
                ->limit(5)
                ->get();

            // Fetch from resource-marketing-company-placed
            $companies = DB::table('resource-marketing-company-placed')
                ->select('sn', 'company_name', 'company_logo', 'created_at')
                ->where([
                    ['category', '=', $category],
                    ['status', '=', 1],
                ])
                ->orderBy('created_at', 'desc')
                // ->limit(5)
                ->get();

            $institutes = DB::table('resource-marketing-institue-placed')
                ->select('sn', 'institue_name', 'institue_logo','created_at')
                ->where([
                    ['category', '=', $category],
                    ['status', '=', 1],
                ])
                ->orderBy('created_at', 'desc')
                // ->limit(5)
                ->get();
            $tutorials = DB::table('resource_tutorials')
                ->select('sn', 'title', 'description', 'icon', 'image', 'created_at')
                ->where([
                    ['category', '=', $category],
                    ['status', '=', 1],
                ])
                ->orderBy('created_at', 'desc')
                ->limit(6)
                ->get();

            $faqs = DB::table('resource_faqs')
                ->select('sn', 'question', 'answer',  'created_at')
                ->where([
                    ['category', '=', $category],
                    ['status', '=', 1],
                ])
                ->orderBy('created_at', 'desc')
                ->limit(6)
                ->get();
            return $this->successResponse([
                'category' => $category,
                'testimonials' => $testimonials,
                'companies' => $companies,
                'institutes' => $institutes,
                'tutorials'    => $tutorials,
                'faqs'         => $faqs,
            ], 'All Data Fetched!!');

        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong! ' . $e->getMessage(), 500);
        }
    }


}
