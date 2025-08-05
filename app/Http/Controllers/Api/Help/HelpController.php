<?php

namespace App\Http\Controllers\Api\Help;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class HelpController extends Controller
{
    public function allHelp(Request $request)
    {
        // $id = $request->input('id');
        // $authkey = $request->input('authkey');

        // if (!$this->isValidUser($id, $authkey)) {
        //     return response()->json(['status' => 'error', 'message' => 'Unauthorized'], 401);
        // }

        return response()->json([
            'status' => 'success',
            'help-videos' => DB::table('help-videos')->where('status', 1)->get(),
            'help-faq' => DB::table('help-faq')->where('status', 1)->get(),
            'notifications' => DB::table('notifications')->select('notificationID', 'displayImage')->where('status', 1)->get()
        ]);
    }
}
