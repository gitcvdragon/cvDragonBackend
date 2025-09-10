<?php

namespace App\Http\Controllers\Api\Admin\Guideshala;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class GuideshalaController extends Controller
{
    /**
     * List all feeds (with summary)
     * Response matches: List Response
     */

    public function listFeeds(Request $request)
    {
        try {
            // validate request params
            $validator = Validator::make($request->all(), [
                'id' => 'nullable|integer|exists:kc-main,kcid',
                'limit'    => 'nullable|integer|min:1|max:100',
                'offset'   => 'nullable|integer|min:0',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => $validator->errors()->first(),
                ], 422);
            }

            $postType = $request->get('id');
            $limit    = $request->get('limit', 10);
            $offset   = $request->get('offset', 0);

            $query = DB::table('kc-feed as f')
                ->join('kc-main as m', 'f.postType', '=', 'm.kcid')
                ->select(
                    'f.feedID as id',
                    'f.postHeading as title',
                    'f.postDescription as shortDesc',
                    'f.postImageLink as thumbnail',
                    'm.kcName as category',
                    'f.postUpdateDate as publishedAt',
                    DB::raw("'Admin' as author")
                )
                ->where('f.status', 1);

            // filter by postType if provided
            if (!empty($postType)) {
                $query->where('f.postType', $postType);
            }

            $feeds = $query
                ->orderByDesc('f.postUpdateDate')
                ->offset($offset)
                ->limit($limit)
                ->get();

            return response()->json([
                'success' => true,
                'data'    => $feeds,
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'error'   => 'Something went wrong: ' . $e->getMessage()
            ], 500);
        }
    }


    /**
     * Single feed details
     * Response matches: Detail Response
     */
    public function feedDetail($id)
    {
        try {
            $feed = DB::table('kc-feed as f')
                ->join('kc-main as m', 'f.postType', '=', 'm.kcid')
                ->select(
                    'f.feedID as id',
                    'f.postHeading as title',
                    'f.postDescription as content',
                    'f.postImageLink',
                    'f.tags'
                )
                ->where('f.feedID', $id)
                ->where('f.status', 1)
                ->first();

            if (!$feed) {
                return response()->json(['error' => 'Feed not found'], 404);
            }

            // images
            $images = DB::table('kc-feed-gallery')
                ->where('feedID', $feed->id)
                ->where('status', 1)
                ->pluck('imageLink')
                ->toArray();

            if (empty($images)) {
                $images = [$feed->postImageLink];
            }

            // related (for demo: latest 2 other feeds)
            $related = DB::table('kc-feed')
                ->where('feedID', '!=', $feed->id)
                ->where('status', 1)
                ->orderByDesc('postUpdateDate')
                ->limit(2)
                ->pluck('feedID')
                ->toArray();

            return response()->json([
                'id'      => $feed->id,
                'title'   => $feed->title,
                'content' => "<p>{$feed->content}</p>", // wrap as HTML
                'images'  => $images,
                'tags'    => !empty($feed->tags) ? explode(',', $feed->tags) : [],
                'related' => $related,
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Something went wrong: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Categories list
     * Response matches: Categories Response
     */
    public function listCategories()
    {
        try {
            $categories = DB::table('kc-main')
                ->select('kcid as id', 'kcName as name')
                ->where('status', 1)
                ->where('kcid','!=' ,0)
                ->orderBy('kcName', 'asc')
                ->get();

            return response()->json([
                'success' => true,
                'data'    => $categories
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'error'   => 'Something went wrong: ' . $e->getMessage()
            ], 500);
        }
    }
}
