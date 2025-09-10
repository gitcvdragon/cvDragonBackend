<?php

namespace App\Http\Controllers\Api\Admin\Guideshala;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class GuideshalaController extends Controller
{
    /**
     * List all feeds (with summary)
     * Response matches: List Response
     */
    public function listFeeds()
    {
        try {
            $feeds = DB::table('kc-feed as f')
                ->join('kc-main as m', 'f.postType', '=', 'm.kcid')
                ->select(
                    'f.feedID as id',
                    'f.postHeading as title',
                    'f.postDescription as shortDesc',
                    'f.postImageLink as thumbnail',
                    'm.kcName as category',
                    'f.postUpdateDate as publishedAt',
                    DB::raw("'Admin' as author") // static for now
                )
                ->where('f.status', 1)
                ->orderByDesc('f.postUpdateDate')
                ->get();

            return response()->json($feeds, 200);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Something went wrong: ' . $e->getMessage()
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
                ->orderBy('kcName', 'asc')
                ->get();

            return response()->json($categories, 200);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Something went wrong: ' . $e->getMessage()
            ], 500);
        }
    }
}
