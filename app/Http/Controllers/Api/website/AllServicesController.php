<?php
namespace App\Http\Controllers\Api\website;

use App\Http\Controllers\Controller;
use App\Traits\ApiResponseTrait;
use Illuminate\Http\Request;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class AllServicesController extends Controller
{
    use ApiResponseTrait;
    use \App\Traits\CryptHelper;

    public function getServicesBlock(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'category' => 'required|string|max:100',
            ]);

            if ($validator->fails()) {
                return $this->errorResponse($validator->errors()->first(), 422);
            }
            $category = $request->input('category') ?? 'services';

            $services = DB::table('microservice')
                ->where('microsite', 'services')
                ->orderBy('order-no', 'asc')
                ->get()
                ->map(function ($service) {
                    return [
                        'image'       => $service->image,
                        'icon'        => $service->icon,
                        'purchases'   => $service->purchases,
                        'name'        => $service->heading,
                        'description' => $service->description,
                        'rating'      => $service->rating,
                        'cost'        => $service->cost,
                        'textDown'        => "",
                        'textRight'        =>"",
                        'color1'        => "",
                         'color2'        => "",

                        'button'      => $service->button,
                        'link'        => $service->link,
                        // 'microsite'          =>  $this->encryptSafe($service->microsite)
                        'microsite'          =>  $service->microsite
                    ];
                });

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
                'category' => $category,

                'services'     => $services,
                'testimonials' => $testimonials,
                'faqs'         => $faqs,
            ], 'All Services Fetched!!');

        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong! ' . $e->getMessage(), 500);
        }
    }

    public function getServicesBlockonClick(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'microsite'     => 'required|string',
                'category'     => 'required|string|max:100',
                'sub_category' => 'required|string|max:100',

            ]);

            if ($validator->fails()) {
                return $this->errorResponse($validator->errors()->first(), 422);
            }
            $category   = $request->input('category') ?? 'services';
            $categoryId = $request->input('sub_category');
            $microsite = $request->input('microsite');
            // $microsite = $this->decryptSafe($request->input('microsite'));

            $services = DB::table('microservice')
                ->where('microsite', '=', $microsite)
                ->orderBy('order-no', 'asc')
                ->get()
                ->map(function ($service) {
                    return [
                        'image'       => $service->image,
                        'icon'        => $service->icon,
                        'purchases'   => $service->purchases,
                        'name'        => $service->heading,
                        'description' => $service->description,
                        'rating'      => $service->rating,
                        'cost'        => $service->cost,

                        'button'      => $service->button,
                        'link'        => $service->link,
                        // 'main'          => $this->encryptSafe($service->main),
                        // 'microsite'          =>  $this->encryptSafe($service->microsite)
                        'main'          => $service->main,
                        'microsite'          =>  $service->microsite
                    ];
                });

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
                ->select('sn', 'question', 'answer', 'created_at','category', 'sub_category')
                ->where([
                    ['category', '=', $category],
                    ['sub_category', '=', $categoryId],

                    ['status', '=', 1],
                ])
                ->orderBy('created_at', 'desc')
                ->limit(5)
                ->get();

            return $this->successResponse([
                'category' => $category,
                'categoryId'=>$categoryId,

                'services'     => $services,
                'testimonials' => $testimonials,
                'faqs'         => $faqs,
            ], 'All Services Fetched!!');

        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong! ' . $e->getMessage(), 500);
        }
    }
    public function getServicesBlockonClickMain(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'category'     => 'required|string|max:50',
                'sub_category' => 'required|string|max:100',

                'main'      => 'required|string',
                'microsite'      => 'required|string',

            ]);

            if ($validator->fails()) {
                return $this->errorResponse($validator->errors()->first(), 422);
            }
            $category   = $request->input('category') ?? 'services';
            $categoryId = $request->input('sub_category');
            // $main = $this->decryptSafe($request->input('main'));
            // $microsite = $this->decryptSafe($request->input('microsite'));
            $main = $request->input('main');
            $microsite = $request->input('microsite');

            $services   = DB::table('microservice')
                ->where('microsite', '=', $microsite)
                ->where('category', '=', "main")
                ->where('main', '=', $main)

                ->orderBy('order-no', 'asc')
                ->get()
                ->map(function ($service) {
                    return [
                        'image'       => $service->image,
                        'icon'        => $service->icon,
                        'purchases'   => $service->purchases,
                        'name'        => $service->heading,
                        'description' => $service->description,
                        'rating'      => $service->rating,
                        'cost'        => $service->cost,
                        'button'      => $service->button,
                        'link'        => $service->link,
                        // 'sn'          => $service->sn,
                    ];
                });

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
                ->select('sn', 'question', 'answer', 'created_at','category', 'sub_category')
                ->where([
                    ['category', '=', $category],
                    ['sub_category', '=', $categoryId],

                    ['status', '=', 1],
                ])
                ->orderBy('created_at', 'desc')
                ->limit(5)
                ->get();

            return $this->successResponse([
                'category' => $category,
                'categoryId'=>$categoryId,
                'services'     => $services,
                'testimonials' => $testimonials,
                'faqs'         => $faqs,
            ], 'All Services Fetched!!');

        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong! ' . $e->getMessage(), 500);
        }
    }
}
