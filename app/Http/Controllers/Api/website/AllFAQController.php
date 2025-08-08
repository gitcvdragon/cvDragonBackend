<?php

namespace App\Http\Controllers\Api\website;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use App\Traits\ApiResponseTrait;

class AllFAQController extends Controller
{
    use ApiResponseTrait;

    public function AllFaqBasedOnCategory(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'category' => 'required|string|max:100',
                'search' => 'nullable|string',
                'sort_by' => 'nullable|string|in:created_at,question',
                'sort_order' => 'nullable|string|in:asc,desc',
                'limit' => 'nullable|integer',
                'offset' => 'nullable|integer'
            ]);

            if ($validator->fails()) {
                return $this->errorResponse($validator->errors()->first(), 422);
            }

            $category = $request->input('category');
            $search = $request->input('search');
            $sortBy = $request->input('sort_by', 'created_at');
            $sortOrder = $request->input('sort_order', 'desc');
            $limit = $request->input('limit', 10);
            $offset = $request->input('offset', 0);

            $query = DB::table('resource_faqs')
                ->select('sn', 'question', 'answer', 'created_at')
                ->where('category', $category)
                ->where('status', 1);

            if ($search) {
                $query->where(function ($q) use ($search) {
                    $q->where('question', 'like', "%$search%")
                      ->orWhere('answer', 'like', "%$search%");
                });
            }

            $faqs = $query->orderBy($sortBy, $sortOrder)
                ->limit($limit)
                ->offset($offset)
                ->get();

            return $this->successResponse(['faqs' => $faqs], 'All Data Fetched!!');
        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong! ' . $e->getMessage(), 500);
        }
    }

    public function AllFaqBasedOnCategorySubCategory(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'category' => 'required|string|max:100',
                'sub_category' => 'required|string|max:100',
                'search' => 'nullable|string',
                'sort_by' => 'nullable|string|in:created_at,question',
                'sort_order' => 'nullable|string|in:asc,desc',
                'limit' => 'nullable|integer',
                'offset' => 'nullable|integer'
            ]);

            if ($validator->fails()) {
                return $this->errorResponse($validator->errors()->first(), 422);
            }

            $category = $request->input('category');
            $sub_category = $request->input('sub_category');
            $search = $request->input('search');
            $sortBy = $request->input('sort_by', 'created_at');
            $sortOrder = $request->input('sort_order', 'desc');
            $limit = $request->input('limit', 10);
            $offset = $request->input('offset', 0);

            $query = DB::table('resource_faqs')
                ->select('sn', 'question', 'answer', 'created_at')
                ->where('category', $category)
                ->where('sub_category', $sub_category)
                ->where('status', 1);

            if ($search) {
                $query->where(function ($q) use ($search) {
                    $q->where('question', 'like', "%$search%")
                      ->orWhere('answer', 'like', "%$search%");
                });
            }

            $faqs = $query->orderBy($sortBy, $sortOrder)
                ->limit($limit)
                ->offset($offset)
                ->get();

            return $this->successResponse(['faqs' => $faqs], 'Data fetched successfully!');
        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong! ' . $e->getMessage(), 500);
        }
    }
}
