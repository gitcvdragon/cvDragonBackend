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

        // $user_id = auth()->user()->id;

        $senderID = auth()->user()->id;

        $receiverID = 1;
        $chat = $request->input('chat');
        $type = $request->input('type');
        $now = Carbon::now();

        $inserted = DB::table('help-chat')->insertGetId([
            'senderID' => $senderID,
            'receiverID' => $receiverID,
            'chat' => $chat,
            'type' => $type,
            'dateCreated' => $now,
            'dateUpdated' => $now,
            'status' => 1
        ]);

        if ($inserted) {
            return $this->successResponse([],'chat added successfully!');
        }

        return $this->successResponse([],'chat not added successfully!', 500);

    }

    public function userChatIndividual(Request $request)
    {
     $id = auth()->user()->id;


        $chatList = DB::table('help-chat')
            ->where(function ($query) use ($id) {
                $query->where('receiverID', $id)
                    ->orWhere('senderID', $id)
                    ->orWhere(function ($q) {
                        $q->where('receiverID', 1)->where('senderID', 1);
                    });
            })
            ->where('status', 1)
            ->orderBy('dateCreated', 'asc')
            ->get();

        return $this->successResponse([
            'chats'   => $chatList

        ], 'All Data Fetched!!');
    }
}
