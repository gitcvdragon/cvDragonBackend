<?php

namespace App\Http\Controllers\Api\Help;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Traits\ApiResponseTrait;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class ChatController extends Controller
{
    use ApiResponseTrait;



    public function addChat(Request $request)
    {
        $senderID = auth()->user()->id;
        $receiverID = 1; // admin or fixed receiver
        $chat = $request->input('chat');
        $type = $request->input('type');
        $now = Carbon::now();

        try {
            DB::beginTransaction();

            $inserted = DB::table('help-chat')->insertGetId([
                'senderID' => $senderID,
                'receiverID' => $receiverID,
                'chat' => $chat,
                'type' => $type,
                'dateCreated' => $now,
                'dateUpdated' => $now,
                'status' => 1
            ]);

            if (!$inserted) {
                DB::rollBack();
                return $this->successResponse([], 'Chat not added successfully!', 500);
            }

            DB::commit();
            return $this->successResponse([], 'Chat added successfully!');
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->successResponse([], 'An error occurred: ' . $e->getMessage(), 500);
        }
    }

    public function userChatIndividual(Request $request)
    {
        $id = auth()->user()->id;

        // Get limit & offset from request (default: 10 items, offset 0)
        $limit  = $request->input('limit', 10);
        $offset = $request->input('offset', 0);

        $chatList = DB::table('help-chat')
            ->select('chat', 'type', 'dateCreated','isResolved','receiverID', 'senderID')
            ->where(function ($query) use ($id) {
                $query->where('receiverID', $id)
                    ->orWhere('senderID', $id)
                    ->orWhere(function ($q) {
                        $q->where('receiverID', 1)->where('senderID', 1);
                    });
            })
            ->where('status', 1)
            ->orderBy('dateCreated', 'asc')
            ->limit($limit)
            ->offset($offset)
            ->get();

        return $this->successResponse([
            'chats'   => $chatList,
            'limit'   => $limit,
            'offset'  => $offset,
        ], 'All Data Fetched!!');
    }

}
