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
            $limit  = $request->input('limit', 2);
            $offset = $request->input('offset', 0);
            $services = DB::table('microservice')
                ->where('microsite', '=', $microsite)
                ->where('microsite', '!=', 'main')
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
            return $this->successResponse([
                'category' => $category,
                'sub_category'=>$categoryId,

                'services'     => $services,
                'testimonials' => $testimonials,
                'faqs'         => $faqs,
                'statistics'  => $statistics,
            ], 'All Services Fetched!!');

        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong! ' . $e->getMessage(), 500);
        }
    }
    public function getServicesBlockonClickMain(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'sn' => 'required|integer|exists:microservice,sn',
                'category'     => 'required|string|max:50',
                'sub_category' => 'required|string|max:100',

                'microsite'      => 'required|string',

            ]);

            if ($validator->fails()) {
                return $this->errorResponse($validator->errors()->first(), 422);
            }
            $category   = $request->input('category') ?? 'services';
            $categoryId = $request->input('sub_category');
            // $main = $this->decryptSafe($request->input('main'));
            // $microsite = $this->decryptSafe($request->input('microsite'));
            $sn = $request->input('sn');
            $microsite = $request->input('microsite');

            $service = DB::table('microservice')
            ->where('sn', $sn)
            ->where('status', 1)
            ->orderBy('order-no', 'asc')
            ->first();

        $service = [
            'sn'                  => $service->sn,
            'image'               => $service->image,
            'name'                => $service->heading,
            'description'         => $service->description,
            'content'             => $service->content,
            'heading1'            => $service->heading1,
            'content1'            => $service->content1,
            'heading2'            => $service->heading2,
            'content2'            => $service->content2,
            'heading3'            => $service->heading3,
            'content3'            => $service->content3,
            'heading4'            => $service->heading4,
            'content4'            => $service->content4,
            'button'              => $service->button,
            'note1'               => $service->note1,
            'note2'               => $service->note2,
            'form'                => $service->form,
            'pp_heading'          => $service->{'pp-heading'},
            'pp_description'      => $service->{'pp-description'},
            'ppp_message'         => $service->{'ppp-message'},
            'trackstatus_headings'=> $service->{'trackstatus-headings'},
            'has_link'            => $service->has_link,
            'link_heading'        => $service->link_heading,
            'link_content'        => $service->link_content,
            'value_1'             => $service->value_1,
            'value_2'             => $service->value_2,
            'value_3'             => $service->value_3,
            'icon'                => $service->icon,
            'target'              => $service->target,
            'banner'              => $service->banner,
            'duration'            => $service->duration,
            'cost'                => $service->cost,
            'offer'               => $service->offer,
            'gst'                 => $service->gst,
            'discount'            => $service->discount,
            'rating'              => $service->rating,
            'purchases'           => $service->purchases,
            'link'                => $service->link,
        ];

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
