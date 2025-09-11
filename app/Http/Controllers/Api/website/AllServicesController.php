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
				 ->where('main', '')
                ->where('status', 1)
                ->orderBy('order-no', 'asc')
                ->get()
                ->map(function ($service) {
                    return [
                        'sn'                  => $service->sn,

                        'image'       => $service->image,
                        'icon'        => $service->icon,
                        'purchases'   => $service->purchases,
                        'name'        => $service->heading,
                        'description' => $service->description,
                        'rating'      => $service->rating,
                        'cost'        => $service->cost,
                        'textDown'        =>$service->textDown,
                        'textRight'        =>$service->textRight,
                        'color1'        => $service->color1,

                        'color2'        => $service->color2,

                        'button'      => $service->button,
                        'link'        => $service->link,
                        // 'microsite'          =>  $this->encryptSafe($service->microsite)
                        'microsite'          =>  $service->category
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
 $services = DB::table('microservice')
                ->where('microsite', 'services')
                ->where('status', 1)
                ->orderBy('order-no', 'asc')
                ->get()
                ->map(function ($service) {
                    return [
                        'sn'                  => $service->sn,

                        'image'       => $service->image,
                        'icon'        => $service->icon,
                        'purchases'   => $service->purchases,
                        'name'        => $service->heading,
                        'description' => $service->description,
                        'rating'      => $service->rating,
                        'cost'        => $service->cost,
                        'textDown'        =>$service->textDown,
                        'textRight'        =>$service->textRight,
                        'color1'        => $service->color1,

                        'color2'        => $service->color2,

                        'button'      => $service->button,
                        'link'        => $service->link,
                        // 'microsite'          =>  $this->encryptSafe($service->microsite)
                        'microsite'          =>  $service->category
                    ];
                });

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
            $limit  = $request->input('limit', 2);
            $offset = $request->input('offset', 0);

            $services = DB::table('microservice')
                ->where('microsite', '=', $microsite)
                ->where('main', '')
                ->where('category', '!=','main')

                ->where('status', 1)

                ->orderBy('order-no', 'asc')
                ->offset($offset)
                ->limit($limit)

                ->get()
                ->map(function ($service) {
                    return [
                        'sn'       => $service->sn,
                        'image'       => $service->image,
                        'icon'        => $service->icon,
                        'purchases'   => $service->purchases,
                        'name'        => $service->heading,
						'category'        => $service->category,
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


                $servicesmain = DB::table('microservice')
                ->where('microsite', '=', $microsite)
                ->where('category', '=','main')
                ->where('main', '')
                ->where('status', 1)

                ->orderBy('order-no', 'asc')


                ->first();



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

                $service = DB::table('microservice')
    ->where('microsite', $microsite)
    ->where('category', 'main')
    ->where('main', '')
    ->where('status', 1)
    ->first();

$result = $service ? [
    'heading'     => $service->heading,
    'description' => $service->description,
] : null;

            return $this->successResponse([
                'heading_details'       => $servicesmain,
                'category' => $category,
                'sub_category'=>$categoryId,
'heading'       => $result['heading'] ?? null,
    'description'   => $result['description'] ?? null,
                'services'     => $services,
                'testimonials' => $testimonials,
                'faqs'         => $faqs,
                'statistics'  => $statistics,
            ], 'All Services Fetched!!');

        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong! ' . $e->getMessage(), 500);
        }
    }

    public function getServicesBlockonMain(Request $request)

    {
        try {
            $validator = Validator::make($request->all(), [
                'sn' => 'required|integer|exists:microservice,sn',


            ]);

            if ($validator->fails()) {
                return $this->errorResponse($validator->errors()->first(), 422);
            }

            $sn = $request->input('sn');


            $service = DB::table('microservice')
            ->where('sn', $sn)
            ->where('status', 1)
            ->first();








            return $this->successResponse([

                'services'     => $service,

                // 'statistics'  => $statistics,
            ], 'Individual Services Fetched!!');

        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong! ' . $e->getMessage(), 500);
        }
    }

    public function getServicesBlockonClickMain(Request $request)

    {
        try {
            $validator = Validator::make($request->all(), [
                'service_category' => 'required|string',
                'category'     => 'required|string|max:50',
                'sub_category' => 'required|string|max:100',

                'microsite'      => 'required|string',

            ]);

            if ($validator->fails()) {
                return $this->errorResponse($validator->errors()->first(), 422);
            }
            $category   = $request->input('category') ?? 'services';
            $category   = $request->input('category') ?? 'services';
            $service_category   = $request->input('service_category') ?? 'services';
            $categoryId = $request->input('sub_category');
            // $main = $this->decryptSafe($request->input('main'));
            // $microsite = $this->decryptSafe($request->input('microsite'));
            $sn = $request->input('sn');
            $microsite = $request->input('microsite');

            $service = DB::table('microservice')
            ->where('microsite', $microsite)
            ->where('main', $service_category)
            ->where('category', 'main')
            ->where('status', 1)
            ->first();



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
                'services'     => $service,
                'testimonials' => $testimonials,
                'faqs'         => $faqs,
                // 'statistics'  => $statistics,
            ], 'All Services Fetched!!');

        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong! ' . $e->getMessage(), 500);
        }
    }



    public function allServicesBlock(Request $request)
    {
        try {


            $category = $request->input('category') ?? 'services';

            $services = DB::table('microservice')
                ->where('microsite', 'services')
                ->orderBy('order-no', 'asc')
                ->where('status', 1)

                ->get()
                ->map(function ($service) {
                    return [
                        'sn'       => $service->sn,
                        'name'       => $service->category,

                    ];
                });


            return $this->successResponse([

                'services'     => $services,

            ], 'All Services Fetched!!');

        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong! ' . $e->getMessage(), 500);
        }
    }
}
