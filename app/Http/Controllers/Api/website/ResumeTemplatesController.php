<?php
namespace App\Http\Controllers\Api\website;

use App\Http\Controllers\Controller;
use App\Traits\ApiResponseTrait;
use App\Traits\CryptHelper;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class ResumeTemplatesController extends Controller
{

    use ApiResponseTrait;
    use CryptHelper;
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
                ->get()
                ->map(function ($item) {
                    if (!empty($item->title)) {
                        try {
                            $item->title =  $this->encryptSafe($item->title);
                        } catch (\Exception $e) {

                        }
                    }      return $item;
                });

            $faqs = DB::table('resource_faqs')
                ->select('sn', 'question', 'answer', 'created_at','category', 'sub_category')
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
                'categories'   => $categories,
                'designs'      => $designs,

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
                'category'     => 'required|string|max:100',
                'category_id'  => 'required|integer',
                'sub_category' => 'required|string|max:100',

            ]);

            if ($validator->fails()) {
                return $this->errorResponse($validator->errors()->first(), 422);
            }
            $category     = $request->input('category');
            $categoryId   = $request->input('category_id');
            $sub_category = $request->input('sub_category');

            $designs = DB::table('resource-profiledesign')
                ->select('design_image','designid as category_id')
                ->where('status', 1)
                ->where('categoryid', $categoryId)
                ->orderBy('downloadTimes', 'desc')
                ->limit(9)

                ->get() ->map(function ($item) {
                    $item->category_id = $this->encryptSafe($item->category_id);
                    return $item;
                });
            $testimonials = DB::table('resource_testimonials')
                ->select('sn', 'title', 'description', 'role', 'rating', 'source', 'created_at')
                ->where([
                    ['category', '=', $category],
                    ['sub_category', '=', $sub_category,
                    ],
                    ['status', '=', 1],
                ])
                ->orderBy('created_at', 'desc')
                ->limit(5)
                ->get();

            $faqs = DB::table('resource_faqs')
                ->select('sn', 'question', 'answer', 'created_at','category', 'sub_category')
                ->where([
                    ['category', '=', $category],
                    ['sub_category', '=', $sub_category],

                    ['status', '=', 1],
                ])
                ->orderBy('created_at', 'desc')
                ->limit(5)
                ->get();
            return $this->successResponse([
                'designs'      => $designs,

                'testimonials' => $testimonials,
                'faqs'         => $faqs,

            ], 'All Data Fetched!!');

        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong! ' . $e->getMessage(), 500);
        }
    }


    public function getDesignsByCategoryIndividual(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'category'     => 'required|string|max:100',
                'category_id'  => 'required|string',
                'sub_category' => 'required|string|max:100',

            ]);

            if ($validator->fails()) {
                return $this->errorResponse($validator->errors()->first(), 422);
            }
            $category     = $request->input('category');
            $categoryId = $this->decryptSafe($request->category_id);

            $sub_category = $request->input('sub_category');

            $designs = DB::table('resource-profiledesign')
                ->select('design_image','isPrivate','isDownload','rating','downloadTimes','heading')
                ->where('status', 1)
                ->where('designid', $categoryId)
                ->first();

            $testimonials = DB::table('resource_testimonials')
                ->select('sn', 'title', 'description', 'role', 'rating', 'source', 'created_at')
                ->where([
                    ['category', '=', $category],
                    ['sub_category', '=', $sub_category,
                    ],
                    ['status', '=', 1],
                ])
                ->orderBy('created_at', 'desc')
                ->limit(5)
                ->get();

            $faqs = DB::table('resource_faqs')
                ->select('sn', 'question', 'answer', 'created_at','category', 'sub_category')
                ->where([
                    ['category', '=', $category],
                    ['sub_category', '=', $sub_category],

                    ['status', '=', 1],
                ])
                ->orderBy('created_at', 'desc')
                ->limit(5)
                ->get();
            return $this->successResponse([
                'designs'      => $designs,

                'testimonials' => $testimonials,
                'faqs'         => $faqs,

            ], 'All Data Fetched!!');

        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong! ' . $e->getMessage(), 500);
        }
    }
}
