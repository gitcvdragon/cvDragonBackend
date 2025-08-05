<?php

namespace App\Http\Controllers\Api\Feed;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class FeedController extends Controller
{

public function getFeedList()
{
    $feeds = DB::table('kc-feed as kf')
        ->join('kc-main as fm', 'kf.postType', '=', 'fm.kcid')
        ->select(
            'kf.feedID',
            'kf.postID',
            'kf.postHeading',
            'kf.postDescription',
            'kf.postHeadingDisplay',
            'kf.postHeadingDescription',
            'kf.postTypeName',
            'kf.postPremium',
            'kf.postMultipleImage',
            'kf.postImageLink',
            'kf.postImagePotrait',
            'kf.postLink',
            'kf.postVideoLink',
            'kf.postButtonText',
            'kf.postDesignID',
            'kf.postType',
            'kf.postPostedBy',
            'kf.postUploadDate',
            'kf.postUpdateDate',
            'kf.postLikes',
            'kf.postShares',
            'kf.adminID',
            'kf.status',
            'fm.kcName as postTypeDisplayName'
        )
        ->where('kf.status', 1)
        ->orderByDesc('kf.postID')
        ->get()
        ->map(function ($feed) {
            $feed->images = ($feed->postMultipleImage == 1)
                ? DB::table('kc-feed-gallery')
                    ->where('feedID', $feed->feedID)
                    ->where('postID', $feed->postID)
                    ->where('status', 1)
                    ->pluck('imageLink')
                : [$feed->postImageLink];

            return $feed;
        });
        return response()->json($feeds);


}
}
