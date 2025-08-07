<?php

namespace App\Http\Controllers\Api\Feed;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Traits\ApiResponseTrait;
use Illuminate\Support\Facades\Validator;

class FeedController extends Controller
{
    use ApiResponseTrait;

public function getFeedList()
{
    try {

    $guidesala = DB::table('kc-feed as kf')
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
        'kf.status',
        'fm.kcName as postTypeDisplayName'
    )
    ->where('kf.status', 1)
    ->where('fm.status', 1)
    ->where('fm.isFeed', 1)
    ->orderByDesc('kf.postID')
    ->get()
    ->map(function ($feed) {
        $guidesala->images = ($guidesala->postMultipleImage == 1)
            ? DB::table('kc-feed-gallery')
                ->where('feedID', $guidesala->feedID)
                ->where('postID', $guidesala->postID)
                ->where('status', 1)
                ->pluck('imageLink')
            : [$guidesala->postImageLink];

        return $guidesala;
    })
    ->groupBy('postTypeDisplayName');

    return $this->successResponse([
        'guidesala' => $guidesala,
    ], 'All Data Fetched!!');


 } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong! ' . $e->getMessage(), 500);
        }
}

}
