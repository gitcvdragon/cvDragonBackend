<?php

namespace App\Http\Controllers\Api\website;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Traits\ApiResponseTrait;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
class MyfavController extends Controller
{
    use ApiResponseTrait;

    public function getFavorites(Request $request)
    {
        try {
            $userId = auth()->id();
            $userId =$request->id;
            if (!$userId) {
                return $this->errorResponse('Unauthorized', 401);
            }
            $limit = $request->input('limit', 10);
            $offset = $request->input('offset', 0);

            $favorites = DB::table('kc-favorites as f')
                ->join('kc-feed as feed', 'f.feedID', '=', 'feed.feedID')
                ->where('f.id', $userId)
                ->where('f.status', 1)
                ->orderBy('f.dateCreated', 'desc')
                ->select(
                    'f.favID',
                    'f.feedID',
                    'f.dateCreated',
                    'feed.postHeading',
                    'feed.postDescription',
                    'feed.postImageLink',
                    'feed.postVideoLink',
                    'feed.postPostedBy',
                    'feed.postUploadDate'
                )
                ->limit($limit)
                ->offset($offset)
                ->get();

            return $this->successResponse(
                ['favorites' => $favorites],
                'Data fetched successfully!'
            );
        } catch (\Exception $e) {
            return $this->errorResponse(
                'Something went wrong! ' . $e->getMessage(),
                500
            );
        }
    }

}
