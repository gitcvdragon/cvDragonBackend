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
                ->get();
                // ->map(function ($item) {
                //     if (!empty($item->id)) {
                //         try {
                //             $item->id =  $this->encryptSafe($item->id);
                //         } catch (\Exception $e) {

                //         }
                //     }      return $item;
                // });

            $faqs = DB::table('resource_faqs')
                ->select('sn', 'question', 'answer', 'created_at','category', 'sub_category')
                ->where([
                    ['category', '=', $category],
                    ['status', '=', 1],
                ])
                ->orderBy('created_at', 'desc')
                ->limit(5)
                ->get();

                $designs = DB::table('resource_profile_design_categories as c')
                ->join('resource-profiledesign as d', 'c.id', '=', 'd.categoryid')
                ->select(
                    'c.id',
                    'c.title',
                    'c.description',
                    'd.design_image',
                    'd.designid as category_id'
                )
                ->where('c.status', 1)
                ->where('d.status', 1)
                ->where('c.id', $category)
                ->orderBy('d.downloadTimes', 'desc')
                ->limit(3)
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


            $categories = DB::table('resource_profile_design_categories')
                ->select('id', 'title', 'description')
                ->where('status', 1)
                ->where('id',  $categoryId)
                ->orderBy('created_at', 'desc')
                ->first();

                $designs = DB::table('resource_profile_design_categories as c')
                ->join('resource-profiledesign as d', 'c.id', '=', 'd.categoryid')
                ->select(
                    'c.id',
                    'c.title',
                    'c.description',
                    'd.design_image',
                    'd.designid as category_id'
                )
                ->where('c.status', 1)
                ->where('d.status', 1)
                ->where('c.id', $categoryId)
                ->orderBy('d.downloadTimes', 'desc')
                ->limit(9)
                ->get();

                // ->get(); ->map(function ($item) {
                //     $item->category_id = $this->encryptSafe($item->category_id);
                //     return $item;
                // });
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
                'heading'   => $categories,
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
                'category_id'  => 'required|integer',
                'sub_category' => 'required|string|max:100',

            ]);

            if ($validator->fails()) {
                return $this->errorResponse($validator->errors()->first(), 422);
            }
            $category     = $request->input('category');
            $categoryId = $request->category_id;
            // $categoryId = $this->decryptSafe($request->category_id);

            $sub_category = $request->input('sub_category');

            $designs = DB::table('resource-profiledesign')
                ->select('designName','design_image','isPrivate','isDownload','rating','downloadTimes','heading')
                ->where('status', 1)
                ->where('designid', $categoryId)
                ->first();
                $categories = DB::table('resource_profile_design_categories')
                ->select( 'title')
                ->where('status', 1)
                ->where('id',  $categoryId)
                ->orderBy('created_at', 'desc')
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
                'heading'   => $categories,
                'designs'      => $designs,

                'testimonials' => $testimonials,
                'faqs'         => $faqs,

            ], 'All Data Fetched!!');

        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong! ' . $e->getMessage(), 500);
        }
    }
}
