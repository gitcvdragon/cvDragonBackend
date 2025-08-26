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
                ->select('sn','category' ,'sub_category','title', 'description', 'role', 'rating', 'source', 'created_at')
                ->where([
                    ['category', '=', $category],
                    ['status', '=', 1],
                ])
                ->orderBy('created_at', 'desc')
                ->limit(5)
                ->get();

            $faqs = DB::table('resource_faqs')
                ->select('sn', 'category' ,'sub_category','question', 'answer', 'created_at','category', 'sub_category')
                ->where([
                    ['category', '=', $category],

                    ['status', '=', 1],
                ])
                ->orderBy('created_at', 'desc')
                ->limit(5)
                ->get();


                $services = DB::table('microservice')
                ->where('microsite', '=', 'services')
                ->where('microsite', '!=', 'main')
                ->orderBy('order-no', 'asc')
                ->limit(2)

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
                        'color1'          => $service->color1,
                        'color2'          => $service->color2,
                        'main'          => $service->main,
                        'microsite'          =>  $service->microsite,
                        'persons_image'      => json_decode($service->persons_image),
                    ];
                });

                $statistics = [
                    [
                        "image" => "https://cvdragon-website-react.web.app/assets/yellow1.svg",
                        "description" => "cv Downloads",
                        "total" => 12
                    ],
                    [
                        "image" => "https://cvdragon-website-react.web.app/assets/yellow1.svg",
                        "description" =>"cv Created",
                        "total" => 8
                    ],
                    [
                        "image" => "https://cvdragon-website-react.web.app/assets/yellow1.svg",
                        "description" => "cv Trained",
                        "total" => 6
                    ],
                    [
                        "image" => "https://cvdragon-website-react.web.app/assets/yellow1.svg",
                        "description" => "cv Downloads",
                        "total" => 3
                    ]
                ];

            return $this->successResponse([
                'category' => $category,


                'testimonials' => $testimonials,
                'faqs'         => $faqs,
                'statistics'  => $statistics,
                'services'    => $services,
            ], 'All Services Fetched!!');

        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong! ' . $e->getMessage(), 500);
        }
    }
}
