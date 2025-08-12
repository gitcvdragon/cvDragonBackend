<?php
namespace App\Http\Controllers\Api\website;

use App\Http\Controllers\Controller;
use App\Traits\ApiResponseTrait;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class AllServicesController extends Controller
{
    use ApiResponseTrait;

    public function getServicesBlock()
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

                        'button'      => $service->button,
                        'link'        => $service->link,
                        'sn'          => $service->sn,
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
                'services'     => $services,
                'testimonials' => $testimonials,
                'faqs'         => $faqs,
            ], 'All Services Fetched!!');

        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong! ' . $e->getMessage(), 500);
        }
    }

    public function getServicesBlockonClick()
    {
        try {
            $validator = Validator::make($request->all(), [
                'category'     => 'required|string|max:100',
                'sub_category' => 'required|string|max:100',

            ]);

            if ($validator->fails()) {
                return $this->errorResponse($validator->errors()->first(), 422);
            }
            $category   = $request->input('category') ?? 'services';
            $categoryId = $request->input('sub_category');

            $services = DB::table('microservice')
                ->where('microsite', '=', $category)
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
                        'sn'          => $service->sn,
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
                'services'     => $services,
                'testimonials' => $testimonials,
                'faqs'         => $faqs,
            ], 'All Services Fetched!!');

        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong! ' . $e->getMessage(), 500);
        }
    }
    public function getServicesBlockonClickMain()
    {
        try {
            $validator = Validator::make($request->all(), [
                'category'     => 'required|string|max:50',
                'sub_category' => 'required|string|max:100',

                'heading'      => 'required|string|max:50',

            ]);

            if ($validator->fails()) {
                return $this->errorResponse($validator->errors()->first(), 422);
            }
            $category   = $request->input('category') ?? 'services';
            $categoryId = $request->input('sub_category');
            $heading    = $request->input('heading');
            $services   = DB::table('microservice')
                ->where('microsite', '=', $category)
                ->where('category', '=', "main")
                ->where('main', '=', $heading)

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
                        'sn'          => $service->sn,
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
                'services'     => $services,
                'testimonials' => $testimonials,
                'faqs'         => $faqs,
            ], 'All Services Fetched!!');

        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong! ' . $e->getMessage(), 500);
        }
    }
}
