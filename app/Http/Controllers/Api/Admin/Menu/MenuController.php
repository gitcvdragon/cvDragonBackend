<?php

namespace App\Http\Controllers\Api\Admin\Menu;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Tymon\JWTAuth\Facades\JWTAuth;

class MenuController extends Controller
{
    /**
     * Fetch all active menus
     */
    public function allMenus()
    {
        $menus = DB::table('resource_menus') // changed from resource-menu
            ->where('status', 1)
            ->orderBy('order_menu') // use snake_case if possible
            ->get();

        return response()->json([
            'menus' => $menus
        ]);
    }

    /**
     * Fetch menus with role permissions
     */
    public function menusByRole($roleId)
    {
        if (!is_numeric($roleId)) {
            return response()->json(['error' => 'Invalid role ID'], 422);
        }

        $menus = DB::table('role_menu as rm')
            ->join('resource_menus as m', 'rm.menu_id', '=', 'm.sn')
            ->where('rm.role_id', $roleId)
            ->where('m.status', 1)
            ->select(
                'm.sn',
                'm.index',
                'm.content',
                'm.heading',
                'm.display_heading',
                'm.order_menu',
                'rm.can_view',
                'rm.can_edit',
                'rm.can_delete'
            )
            ->orderBy('m.order_menu')
            ->get();

        return response()->json([
            'menus' => $menus
        ]);
    }

    /**
     * Fetch menus for the logged-in admin
     */
    public function getMenu(Request $request)
    {
        $user = JWTAuth::user(); // safer than auth()->user()

        if (!$user) {
            return response()->json(['error' => 'User not found'], 404);
        }

        $roleId = $user->role_id;

        $menus = DB::table('role_menu as rm')
            ->join('resource_menus as m', 'rm.menu_id', '=', 'm.sn')
            ->where('rm.role_id', $roleId)
            ->where('m.status', 1)
            ->select(
                'm.sn',
                'm.index',
                'm.content',
                'm.heading',
                'm.display_heading',
                'm.order_menu',
                'rm.can_view',
                'rm.can_edit',
                'rm.can_delete'
            )
            ->orderBy('m.order_menu')
            ->get();

        return response()->json([
            'menus' => $menus
        ]);
    }
}
