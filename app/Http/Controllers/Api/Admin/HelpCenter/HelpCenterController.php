<?php

namespace App\Http\Controllers\Api\Admin\HelpCenter;


use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Traits\ApiResponseTrait;
use App\Traits\CryptHelper;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Crypt;
use Carbon\Carbon;
class HelpCenterController extends Controller
{
    use ApiResponseTrait;

    public function getAllFeedTypes()
    {
        try {
            $feeds = DB::table('kc-main')
                ->select('kcid', 'kcName','icon')
                ->where('isFeed', 1)

                ->orderBy('kcName', 'asc')
                ->get();

            return $this->successResponse([
                'feedTypes' => $feeds,
            ], 'Feed types fetched successfully!');
        } catch (\Exception $e) {
            return $this->errorResponse('Something went wrong: ' . $e->getMessage(), 500);
        }
    }

    public function getFeedListforsingle(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'postType' => 'required|integer|exists:kc-main,kcid',
            'limit'    => 'nullable|integer|min:1',
            'offset'   => 'nullable|integer|min:0',
            'search'   => 'nullable|string|max:255',
        ]);

        if ($validator->fails()) {
            return $this->errorResponse($validator->errors()->first(), 422);
        }

        try {
            $postType = $request->postType;
            $limit    = $request->get('limit', 10);
            $offset   = $request->get('offset', 0);
            $search   = $request->get('search');

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
                return $items->take(7)->map(function ($item) use ($galleryImages) {
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

            return $this->successResponse([
                'guideshala' => $grouped,
            ], 'Public feed fetched successfully!');
        } catch (\Exception $e) {
            \Log::error('Feed fetch failed', ['error' => $e->getMessage()]);
            return $this->errorResponse('Something went wrong while fetching feed', 500);
        }
    }

    public function getUserChats(Request $request)
{
    $validator = Validator::make($request->all(), [
        'limit'     => 'nullable|integer|min:1',
        'offset'    => 'nullable|integer|min:0',
        'search'    => 'nullable|string|max:255',
        'sort_by'   => 'nullable|string|in:dateCreated,username',
        'sort_order'=> 'nullable|string|in:asc,desc',
    ]);

    if ($validator->fails()) {
        return response()->json(['message' => $validator->errors()->first()], 422);
    }

    try {
        $limit     = $request->input('limit', 10);
        $offset    = $request->input('offset', 0);
        $search    = $request->input('search');
        $sortBy    = $request->input('sort_by', 'hc.dateCreated');
        $sortOrder = $request->input('sort_order', 'desc');

        // Subquery: Get last chat per user
        $lastMessages = DB::table('help-chat as hc1')
            ->select(
                'hc1.chatID',
                'hc1.senderID',
                'hc1.receiverID',
                'hc1.chat',
                'hc1.dateCreated'
            )
            ->whereRaw('hc1.chatID IN (SELECT MAX(chatID) FROM `help-chat` GROUP BY senderID, receiverID)');

        // Join with users
        $query = DB::table('users as u')
            ->joinSub($lastMessages, 'hc', function ($join) {
                $join->on('u.id', '=', 'hc.senderID')
                     ->orOn('u.id', '=', 'hc.receiverID');
            })
            ->select(
                'u.id as userID',
                'u.username',
                'u.userEmail',
                'u.usermobile',
                'hc.chat as last_message',
                'hc.dateCreated as last_message_date'
            );

        // Search (by username, email, mobile)
        if (!empty($search)) {
            $query->where(function ($q) use ($search) {
                $q->where('u.username', 'LIKE', "%{$search}%")
                  ->orWhere('u.userEmail', 'LIKE', "%{$search}%")
                  ->orWhere('u.usermobile', 'LIKE', "%{$search}%");
            });
        }

        // Sorting
        $query->orderBy($sortBy, $sortOrder);

        // Pagination
        $total = $query->count();
        $users = $query->offset($offset)->limit($limit)->get();

        return response()->json([
            'success' => true,
            'message' => 'User chat list fetched successfully.',
            'data' => [
                'total' => $total,
                'users' => $users,
            ]
        ]);

    } catch (\Exception $e) {
        return response()->json([
            'success' => false,
            'message' => 'Failed to fetch chats.',
            'error' => $e->getMessage(),
        ], 500);
    }
}


public function deleteFaq(Request $request)
{
    $validator = Validator::make($request->all(), [
        'faqID' => 'required|integer|exists:help-faq,faqID',
    ]);

    if ($validator->fails()) {
        return response()->json(['error' => $validator->errors()->first()], 422);
    }

    try {
        $updated = DB::table('help-faq')
            ->where('faqID', $request->faqID)
            ->update(['status' => 0]);

        if ($updated) {
            return response()->json(['message' => 'FAQ deleted (status set to 0) successfully.']);
        }

        return response()->json(['message' => 'FAQ not found or already inactive.'], 404);

    } catch (\Exception $e) {
        return response()->json(['error' => $e->getMessage()], 500);
    }
}



public function deleteVideo(Request $request)
{
    $validator = Validator::make($request->all(), [
        'videoID' => 'required|integer|exists:help-videos,videoID',
    ]);

    if ($validator->fails()) {
        return response()->json(['error' => $validator->errors()->first()], 422);
    }

    try {
        $updated = DB::table('help-videos')
            ->where('videoID', $request->videoID)
            ->update(['status' => 0]);

        if ($updated) {
            return response()->json(['message' => 'Video deleted (status set to 0) successfully.']);
        }

        return response()->json(['message' => 'Video not found or already inactive.'], 404);

    } catch (\Exception $e) {
        return response()->json(['error' => $e->getMessage()], 500);
    }
}

public function getAllFaqs(Request $request)
{
    $validator = Validator::make($request->all(), [
        'limit'     => 'nullable|integer|min:1',
        'offset'    => 'nullable|integer|min:0',
        'search'    => 'nullable|string|max:255',
        'status'    => 'nullable|in:0,1',
        'app'       => 'nullable|in:0,1',
        'web'       => 'nullable|in:0,1',
    ]);

    if ($validator->fails()) {
        return response()->json(['message' => $validator->errors()->first()], 422);
    }

    try {
        $limit  = $request->input('limit', 10);
        $offset = $request->input('offset', 0);
        $search = $request->input('search');

        $query = DB::table('help-faq')
        ->select('faqID', 'faq', 'answer', 'created_at')
        ->where('status', 1)
        ->when($search, function ($query, $search) {
            return $query->where('faq', 'LIKE', "%{$search}%")
                         ->orWhere('answer', 'LIKE', "%{$search}%");
        })
        ->orderByDesc('created_at');

        $total = $query->count();
        $faqs  = $query->offset($offset)->limit($limit)->get();

        return response()->json([
            'success' => true,
            'message' => 'FAQs fetched successfully.',
            'data' => [
                'total' => $total,
                'faqs'  => $faqs,
            ]
        ]);
    } catch (\Exception $e) {
        return response()->json([
            'success' => false,
            'message' => 'Failed to fetch FAQs.',
            'error' => $e->getMessage()
        ], 500);
    }
}
public function getAllVideos(Request $request)
{
    $validator = Validator::make($request->all(), [
        'limit'   => 'nullable|integer|min:1',
        'offset'  => 'nullable|integer|min:0',
        'search'  => 'nullable|string|max:200',
        'status'  => 'nullable|in:0,1',
        'app'     => 'nullable|in:0,1',
        'web'     => 'nullable|in:0,1',
    ]);

    if ($validator->fails()) {
        return response()->json(['message' => $validator->errors()->first()], 422);
    }

    try {
        $limit  = $request->input('limit', 10);
        $offset = $request->input('offset', 0);
        $search = $request->input('search');

        $query = DB::table('help-videos')
        ->select('videoID', 'heading', 'link', 'dateCreated')
        ->where('status', 1)
        ->when($search, function ($query, $search) {
            return $query->where('heading', 'LIKE', "%{$search}%")
                         ->orWhere('link', 'LIKE', "%{$search}%");
        })
        ->orderByDesc('dateCreated');

        $total  = $query->count();
        $videos = $query->offset($offset)->limit($limit)->get();

        return response()->json([
            'success' => true,
            'message' => 'Videos fetched successfully.',
            'data' => [
                'total'  => $total,
                'videos' => $videos,
            ]
        ]);
    } catch (\Exception $e) {
        return response()->json([
            'success' => false,
            'message' => 'Failed to fetch videos.',
            'error'   => $e->getMessage()
        ], 500);
    }
}

public function addChat(Request $request)
{
    $validator = Validator::make($request->all(), [
        // senderID comes from auth, so no need to validate request senderID
        'receiverID' => 'required|integer|exists:users,id',
        'chat'       => 'required|string',
        'type'       => 'required|integer',
    ]);

    if ($validator->fails()) {
        return response()->json([
            'success' => false,
            'message' => $validator->errors()->first()
        ], 422);
    }

    $senderID = auth()->user()->id;
    $receiverID = $request->input('receiverID');
    $chat       = $request->input('chat');
    $type       = $request->input('type');
    $now = Carbon::now();

    try {
        DB::beginTransaction();

        $inserted = DB::table('help-chat')->insertGetId([
            'senderID'    => $senderID,
            'receiverID'  => $receiverID,
            'chat'        => $chat,
            'type'        => $type,
            'dateCreated' => $now,
            'dateUpdated' => $now,
            'status'      => 1
        ]);

        if (!$inserted) {
            DB::rollBack();
            return response()->json([
                'success' => false,
                'message' => 'Chat not added successfully!'
            ], 500);
        }

        DB::commit();
        return response()->json([
            'success' => true,
            'message' => 'Chat added successfully!',
            'chatID'  => $inserted,
        ], 201);

    } catch (\Exception $e) {
        DB::rollBack();
        return response()->json([
            'success' => false,
            'message' => 'An error occurred: ' . $e->getMessage()
        ], 500);
    }
}

public function userChatIndividual(Request $request)
{
    $validator = Validator::make($request->all(), [
        'user_id' => 'required|integer|exists:users,id',
        'limit'   => 'nullable|integer|min:1',
        'offset'  => 'nullable|integer|min:0',
    ]);

    if ($validator->fails()) {
        return response()->json([
            'success' => false,
            'message' => $validator->errors()->first()
        ], 422);
    }

    $userId = $request->input('user_id');
    $limit  = $request->input('limit', 10);
    $offset = $request->input('offset', 0);

    $chatList = DB::table('help-chat')
        ->select('chatID','chat','type','dateCreated','isResolved','receiverID','senderID')
        ->where(function ($query) use ($userId) {
            $query->where('receiverID', $userId)
                  ->orWhere('senderID', $userId);
        })
        ->where('status', 1)
        ->orderBy('dateCreated', 'desc')
        ->limit($limit)
        ->offset($offset)
        ->get();

    $chatList = $chatList->map(function ($chat) use ($userId) {
        $chat->myChat = ($chat->senderID == $userId) ? 'yes' : 'no';
        return $chat;
    });

    return response()->json([
        'success' => true,
        'message' => 'Chats fetched successfully!',
        'data'    => [
            'chats'  => $chatList,
            'limit'  => $limit,
            'offset' => $offset,
        ]
    ], 200);
}

}
