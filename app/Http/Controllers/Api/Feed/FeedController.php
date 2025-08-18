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
                    'kf.feedID',
                    'kf.postID',
                    'kf.postHeading',
                    'kf.postType',
                    'kf.postDescription',
                    'kf.postImageLink',
                    'kf.postVideoLink',
                    'kf.postMultipleImage',
                    'kf.postLink',
                    'kf.postUpdateDate',
                    'fm.kcName as postTypeDisplayName',
                    'fm.kcType as tags'
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
                        // 'postType'       => $this->encryptSafe($item->postType),
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

            return $this->successResponse([
                'guideshala' => $grouped,
            ], 'Public feed fetched successfully!');
        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong: ' . $e->getMessage(), 500);
        }
    }

    public function getFeedListforsingle(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'postType' => 'required|integer',
             'limit'    => 'nullable|integer|min:1',
        'offset'   => 'nullable|integer|min:0',
        ]);

        if ($validator->fails()) {
            return $this->errorResponse($validator->errors()->first(), 422);
        }
        try {

            // $postType = $this->decryptSafe($request->postType);
            $postType = $request->postType;
         $limit    = $request->get('limit', 10);
        $offset   = $request->get('offset', 0);

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
                    'fm.kcName as postTypeDisplayName'
                )
                ->where('kf.status', 1)
                ->where('fm.status', 1)
                ->where('fm.isFeed', 1)
                ->where('kf.postType', $postType)
                ->orderByDesc('kf.postUpdateDate')
                  ->offset($offset)
            ->limit($limit)
                ->get();

            $grouped = $allFeeds->groupBy('postTypeDisplayName')->map(function ($items) {
                return $items->take(7)->map(function ($item) {
                    // Handle images
                    $images = ($item->postMultipleImage == 1)
                        ? DB::table('kc-feed-gallery')
                            ->where('feedID', $item->feedID)
                            ->where('postID', $item->postID)
                            ->where('status', 1)
                            ->pluck('imageLink')
                            ->toArray()
                        : [];

                    return [
                        'title'       => $item->postHeading,
                        'description' => $item->postDescription,
                        'images'      => $images,
                        'video_link'  => $item->postVideoLink,
                        'postImageLink'  => $item->postImageLink,
                        'link'        => $item->postLink,
                        'updated_at'  => $item->postUpdateDate,
                    ];
                });
            });

            return $this->successResponse([
                'guideshala' => $grouped,
            ], 'Public feed fetched successfully!');
        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong: ' . $e->getMessage(), 500);
        }
    }
public function getAllFeedTypes()
{
    try {
        $feeds = DB::table('kc-main')
            ->select('kcid', 'kcName')
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

}
