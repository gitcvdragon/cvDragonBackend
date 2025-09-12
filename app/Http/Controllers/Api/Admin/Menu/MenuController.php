<?php

namespace App\Http\Controllers\Api\Admin\Menu;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Tymon\JWTAuth\Facades\JWTAuth;

class MenuController extends Controller
{

   public function getMenu(Request $request)
{
    try {
        // Parse the token from request
        $token = JWTAuth::getToken();
        if (!$token) {
            return response()->json(['error' => 'Token not provided'], 401);
        }

        // Decode payload (claims)
        $payload = JWTAuth::getPayload($token)->toArray();

        $roleId = $payload['role_id'];

        $menus = DB::table('role_menu as rm')
            ->join('resource-menu as m', 'rm.menu_id', '=', 'm.sn')
            ->where('rm.role_id', $roleId)
            ->where('m.status', 0)
            ->select(

                'm.*',

            )
            ->orderBy('m.orderMenu')
            ->get();

        return response()->json([
            'menus' => $menus
        ]);

    } catch (\Exception $e) {
        return response()->json(['error' => 'Unauthorized', 'message' => $e->getMessage()], 401);
    }
}
}
