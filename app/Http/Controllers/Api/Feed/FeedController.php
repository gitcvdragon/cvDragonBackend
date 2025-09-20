<?php

namespace App\Http\Controllers\Api\Feed;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Traits\ApiResponseTrait;
use App\Traits\CryptHelper;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Crypt;

class FeedController extends Controller
{
    use ApiResponseTrait;
    use CryptHelper;
    public function getFeedList()
    {
        try {
            $allFeeds = DB::table('kc-feed as kf')
                ->join('kc-main as fm', 'kf.postType', '=', 'fm.kcid')
                ->select(
                    'kf.faq_category as category',
                    'kf.faq_category_sub_category as sub_category',
                    'kf.category_color',
                    'kf.feedID',
                    'kf.postID',
                    'kf.tags',
                    'kf.postHeading',
                    'kf.postType',
                    'kf.postDescription',
                    'kf.postImageLink',
                    'kf.postVideoLink',
                    'kf.postMultipleImage',
                    'kf.postLink',
                    'kf.postUpdateDate',
                    'fm.kcName as postTypeDisplayName',
                    'fm.kcType'
                )
                ->where('kf.status', 1)
                ->where('fm.status', 1)
                ->where('fm.isFeed', 1)
                ->orderByDesc('kf.postUpdateDate')
                ->get();

            $grouped = $allFeeds->groupBy('postTypeDisplayName')->map(function ($items) {
                return $items->take(4)->map(function ($item) {
                    // Handle images
                    // $images = ($item->postMultipleImage == 1)
                    //     ? DB::table('kc-feed-gallery')
                    //         ->where('feedID', $item->feedID)
                    //         ->where('postID', $item->postID)
                    //         ->where('status', 1)
                    //         ->pluck('imageLink')
                    //         ->toArray()
                    //     : [$item->postImageLink];

                    return [

                        'feedID'       => $item->feedID,

                        'category_color'       => $item->category_color,
                        'category'       => $item->category,
                        'sub_category'       => $item->sub_category,
                        'postType'       => $item->postType,
                        'title'       => $item->postHeading,
                        'description' => $item->postDescription,
                        // 'images'      => $images,
                        'images'      => $item->postImageLink,

                        'video_link'  => $item->postVideoLink,
                        'link'        => $item->postLink,
                        'updated_at'  => $item->postUpdateDate,
                        'tags'  => $item->tags,
                    ];
                });
            });
            $images = DB::table('enhance_career_image')
            ->select('sn','image')
            ->where([
                ['category', '=', 'guidesala'],

                ['status', '=', 1],
            ])
            ->orderBy('created_at', 'desc')
            ->limit(10)
            ->get();
            return $this->successResponse([
                'guideshala' => $grouped,
                'article_bg_images' => $images,
            ], 'Public feed fetched successfully!');
        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong: ' . $e->getMessage(), 500);
        }
    }

   public function getFeedListforsingle(Request $request)
{
    $validator = Validator::make($request->all(), [
        'postType' => 'nullable|integer|exists:kc-main,kcid',
        'limit'    => 'nullable|integer|min:1',
        'offset'   => 'nullable|integer|min:0',
        'search'   => 'nullable|string|max:255',
    ]);

    if ($validator->fails()) {
        return $this->errorResponse($validator->errors()->first(), 422);
    }

    try {
        $postType = $request->postType;
        $limit    = $request->get('limit', 7);
        $offset   = $request->get('offset', 0);
        $search   = $request->get('search');
if($postType!=''){
        $allFeeds = DB::table('kc-main as fm')
            ->join('kc-feed as kf', 'kf.postType', '=', 'fm.kcid')
            ->select(
                'kf.feedID',
                'kf.postID',
                'kf.faq_category as category',
                'kf.category_color',
                'kf.faq_category_sub_category as sub_category',
                'kf.tags',
                'kf.postHeading',
                'kf.postDescription',
                'kf.postImageLink',
                'kf.postVideoLink',
                'kf.postMultipleImage',
                'kf.postLink',
                'kf.postUpdateDate',
                'fm.kcName as postTypeDisplayName'
            )
            ->where('kf.status', 1)
            ->where('fm.status', 1)
            ->where('fm.isFeed', 1)
        ->where('kf.postType', $postType)

            ->when($search, function ($query, $search) {
                return $query->where(function ($q) use ($search) {
                    $q->where('kf.postHeading', 'LIKE', "%{$search}%")
                      ->orWhere('kf.postDescription', 'LIKE', "%{$search}%");
                });
            })
            ->orderByDesc('kf.postUpdateDate')
            ->offset($offset)
            ->limit($limit)
            ->get();
//dd(  $allFeeds);
        // Fetch all gallery images in one query to avoid N+1
        $feedIds   = $allFeeds->pluck('feedID');
        $postIds   = $allFeeds->pluck('postID');

        $galleryImages = DB::table('kc-feed-gallery')
            ->whereIn('feedID', $feedIds)
            ->whereIn('postID', $postIds)
            ->where('status', 1)
            ->get()
            ->groupBy(fn($img) => $img->feedID . '_' . $img->postID);

        $grouped = $allFeeds->groupBy('postTypeDisplayName')->map(function ($items) use ($galleryImages) {
            return $items->map(function ($item) use ($galleryImages) {
                $images = ($item->postMultipleImage == 1)
                    ? ($galleryImages[$item->feedID . '_' . $item->postID] ?? collect())->pluck('imageLink')->toArray()
                    : [];

                return [
                    'feedID'        => $item->feedID,
                    'category_color'=> $item->category_color,
                    'category'      => $item->category,
                    'sub_category'  => $item->sub_category,
                    'postType'      => $item->postTypeDisplayName,
                    'title'         => $item->postHeading,
                    'description'   => $item->postDescription,
                    'tags'          => $item->tags,
                    'images'        => $images,
                    'video_link'    => $item->postVideoLink,
                    'postImageLink' => $item->postImageLink,
                    'link'          => $item->postLink,
                    'updated_at'    => $item->postUpdateDate,
                ];
            });
        });
    }else{
       $allFeeds = DB::table('kc-main as fm')
    ->join('kc-feed as kf', 'kf.postType', '=', 'fm.kcid')
    ->select(
        'kf.feedID',
        'kf.postID',
        'kf.faq_category as category',
        'kf.category_color',
        'kf.faq_category_sub_category as sub_category',
        'kf.tags',
        'kf.postHeading',
        'kf.postDescription',
        'kf.postImageLink',
        'kf.postVideoLink',
        'kf.postMultipleImage',
        'kf.postLink',
        'kf.postUpdateDate',
        'fm.kcName as postTypeDisplayName'
    )
    ->where('kf.status', 1)
    ->where('fm.status', 1)
    ->where('fm.isFeed', 1)
    ->when($search, function ($query, $search) {
        return $query->where(function ($q) use ($search) {
            $q->where('kf.postHeading', 'LIKE', "%{$search}%")
              ->orWhere('kf.postDescription', 'LIKE', "%{$search}%");
        });
    })
    ->orderByDesc('kf.postUpdateDate')
    ->offset($offset)
    ->limit($limit)
    ->get();

// Fetch gallery images
$feedIds = $allFeeds->pluck('feedID');
$postIds = $allFeeds->pluck('postID');

$galleryImages = DB::table('kc-feed-gallery')
    ->whereIn('feedID', $feedIds)
    ->whereIn('postID', $postIds)
    ->where('status', 1)
    ->get()
    ->groupBy(fn($img) => $img->feedID . '_' . $img->postID);

// Map feeds with images
$FAQs = $allFeeds->map(function ($item) use ($galleryImages) {
    $images = ($item->postMultipleImage == 1)
        ? ($galleryImages[$item->feedID . '_' . $item->postID] ?? collect())->pluck('imageLink')->toArray()
        : [];

    return [
        'feedID'        => $item->feedID,
        'category_color'=> $item->category_color,
        'category'      => $item->category,
        'sub_category'  => $item->sub_category,
        'postType'      => $item->postTypeDisplayName,
        'title'         => $item->postHeading,
        'description'   => $item->postDescription,
        'tags'          => $item->tags,
        'images'        => $images,
        'video_link'    => $item->postVideoLink,
        'postImageLink' => $item->postImageLink,
        'link'          => $item->postLink,
        'updated_at'    => $item->postUpdateDate,
    ];
});

// Return with your helper
return $this->successResponse([
    'guideshala' => [
        'FAQs' => $FAQs
    ]
], 'Public feed fetched successfully!');
    }
        return $this->successResponse([
            'guideshala' => $grouped,
        ], 'Public feed fetched successfully!');
    } catch (\Exception $e) {
        \Log::error('Feed fetch failed', ['error' => $e->getMessage()]);
        return $this->errorResponse('Something went wrong while fetching feed', 500);
    }
}

public function getAllFeedTypes()
{
    try {
        $feeds = DB::table('kc-main')
            ->select('kcid', 'kcName','icon','link')
            ->where('isFeed', 1)
            ->where('status', 1)
            ->orderBy('kcName', 'asc')
            ->get();

        return $this->successResponse([
            'feedTypes' => $feeds,
        ], 'Feed types fetched successfully!');
    } catch (\Exception $e) {
        return $this->errorResponse('Something went wrong: ' . $e->getMessage(), 500);
    }
}
public function getSingleFeed(Request $request)
{
    $validator = Validator::make($request->all(), [
        'postType' => 'required',
        'feedID' => 'required|integer',
        'limit'  => 'nullable|integer|min:1',
        'offset' => 'nullable|integer|min:0',
    ]);

    if ($validator->fails()) {
        return $this->errorResponse($validator->errors()->first(), 422);
    }

    try {
        $feed = DB::table('kc-feed as kf')
            ->join('kc-main as fm', 'kf.postType', '=', 'fm.kcid')
            ->select(
                'kf.feedID',
                'kf.postID',
                'kf.category_color',
                'kf.faq_category as category',
                    'kf.faq_category_sub_category as sub_category',
                'kf.tags',
                'kf.postHeading',
                'kf.postDescription',
                'kf.postImageLink',
                'kf.postVideoLink',
                'kf.postMultipleImage',
                'kf.postLink',
                'kf.postUpdateDate',
                'fm.kcName as postTypeDisplayName'
            )
            ->where('kf.status', 1)
            ->where('fm.status', 1)
            ->where('fm.isFeed', 1)
            ->where('kf.feedID', $request->feedID)
            ->first();

        if (!$feed) {
            return $this->errorResponse('Feed not found', 404);
        }

        $images = ($feed->postMultipleImage == 1)
            ? DB::table('kc-feed-gallery')
                ->where('feedID', $feed->feedID)
                ->where('postID', $feed->postID)
                ->where('status', 1)
                ->pluck('imageLink')
                ->toArray()
            : [$feed->postImageLink];

        $data = [
            'feedID'       => $feed->feedID,
            'category_color'       => $feed->category_color,

            'category'       => $feed->category,
            'sub_category'       => $feed->sub_category,
            'title'        => $feed->postHeading,
            'description'  => $feed->postDescription,
            'images'       => $images,
            'video_link'   => $feed->postVideoLink,
            'tags'         => $feed->tags,
            'link'         => $feed->postLink,
            'updated_at'   => $feed->postUpdateDate,
            'postType'     => $feed->postTypeDisplayName,
        ];

        $limit  = $request->get('limit', 3);
        $offset = $request->get('offset', 0);

        $trendingTutorials = DB::table('kc-feed as kf')
            ->join('kc-main as fm', 'kf.postType', '=', 'fm.kcid')
            ->select(
                'kf.feedID',
                'kf.postID',
                'kf.tags',
                'kf.postHeading as title',
                'kf.postDescription as description',
                'kf.postImageLink',
                'kf.postVideoLink',
                'kf.postLink',
                'kf.postUpdateDate',
                'fm.kcName as postTypeDisplayName'
            )
            ->where('kf.postType', $request->postType)
            ->where('kf.status', 1)
            ->where('fm.status', 1)
            ->where('fm.isFeed', 1)
            ->orderByDesc('kf.postUpdateDate')
            ->offset($offset)
            ->limit($limit)
            ->get();

        return $this->successResponse([
            'feed'              => $data,
            'trendingTutorials' => $trendingTutorials,
        ], 'Feed details fetched successfully!');

    } catch (\Exception $e) {
        return $this->errorResponse('Something went wrong: ' . $e->getMessage(), 500);
    }
}

}
