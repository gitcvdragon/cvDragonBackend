<?php

namespace App\Http\Controllers\Api\website;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
    use Illuminate\Support\Facades\DB;
    use Illuminate\Support\Facades\Validator;
use App\Traits\ApiResponseTrait;

class HomeController extends Controller
{

    use ApiResponseTrait;
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
                ->limit(5)
                ->get();

            $institutes = DB::table('resource-marketing-institue-placed')
                ->select('sn', 'institue_name', 'institue_logo','created_at')
                ->where([
                    ['category', '=', $category],
                    ['status', '=', 1],
                ])
                ->orderBy('created_at', 'desc')
                ->limit(5)
                ->get();
            // $tutorials = DB::table('resource_tutorials')
            //     ->select('sn', 'title', 'description', 'icon', 'image', 'created_at')
            //     ->where([
            //         ['category', '=', $category],
            //         ['status', '=', 1],
            //     ])
            //     ->orderBy('created_at', 'desc')
            //     ->limit(5)
            //     ->get();

            $faqs = DB::table('resource_faqs')
                ->select('sn', 'question', 'answer',  'created_at','category', 'sub_category')
                ->where([
                    ['category', '=', $category],
                    ['status', '=', 1],
                ])
                ->orderBy('created_at', 'desc')
                ->limit(5)
                ->get();

                $designs = DB::table('resource-profiledesign')
                ->select('design_image','designid','categoryid')
                ->where('status', 1)
                ->orderBy('downloadTimes', 'desc')
                ->limit(15)
                ->get();


                $allFeeds = DB::table('kc-feed as kf')
                ->join('kc-main as fm', 'kf.postType', '=', 'fm.kcid')
                ->select(
                    'kf.feedID',
                    'kf.postID',
                    'kf.postHeading',
                    'kf.postDescription',
                    'kf.postImageLink',
                    'kf.postVideoLink',
                    'kf.postMultipleImage',
                    'kf.postLink',
                    'kf.postUpdateDate',
                    'kf.postLikes',
                    'fm.kcName as postTypeDisplayName',
                    'fm.kcType as tags'

                )
                ->where('kf.status', 1)
                ->where('fm.status', 1)
                ->where('fm.isFeed', 1)
                ->orderBy('kf.postLikes', 'desc')
               ->orderBy('kf.postUpdateDate', 'desc')

                ->get();

            $grouped = $allFeeds->groupBy('postTypeDisplayName')->map(function ($items) {
                return $items->take(5)->map(function ($item) {
                    // Handle images

                    return [
                        'title'       => $item->postHeading,
                        'description' => $item->postDescription,
                        'images'      => $item->postImageLink,
                        'video_link'  => $item->postVideoLink,
                        'link'        => $item->postLink,
                        'updated_at'  => $item->postUpdateDate,
                        'tags'  => $item->tags,

                    ];
                });
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
                'companies' => $companies,
                'institutes' => $institutes,
                // 'tutorials'    => $tutorials,
                'faqs'         => $faqs,
                'designs'         => $designs,
                'guideshala' => $grouped,
'statistics' => $statistics
            ], 'All Data Fetched!!');

        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong! ' . $e->getMessage(), 500);
        }
    }


}
