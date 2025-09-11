<?php

namespace App\Http\Controllers\Api\Admin\Menu;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class MenuController extends Controller
{
    /**
     * Fetch all active menus
     */
    public function allMenus()
    {
        $menus = DB::table('resource-menu')
            ->where('status', 1)
            ->orderBy('orderMenu')
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
        $menus = DB::table('role_menu as rm')
            ->join('resource-menu as m', 'rm.menu_id', '=', 'm.sn')
            ->where('rm.role_id', $roleId)
            ->where('m.status', 1)
            ->select(
                'm.sn',
                'm.index',
                'm.content',
                'm.heading',
                'm.displayHeading',
                'm.orderMenu',
                'rm.can_view',
                'rm.can_edit',
                'rm.can_delete'
            )
            ->orderBy('m.orderMenu')
            ->get();

        return response()->json([
            'menus' => $menus
        ]);
    }

    /**
     * Optional: Fetch menus for the logged-in admin
     */
    public function menusForLoggedInUser(Request $request)
    {
        $userId = auth()->user()->id;

        $user = DB::table('admin_users')->where('id', $userId)->first();
        if (!$user) {
            return response()->json(['error' => 'User not found'], 404);
        }

        $roleId = $user->role_id;

        $menus = DB::table('role_menu as rm')
            ->join('resource-menu as m', 'rm.menu_id', '=', 'm.sn')
            ->where('rm.role_id', $roleId)
            ->where('m.status', 1)
            ->select(
                'm.sn',
                'm.index',
                'm.content',
                'm.heading',
                'm.displayHeading',
                'm.orderMenu',
                'rm.can_view',
                'rm.can_edit',
                'rm.can_delete'
            )
            ->orderBy('m.orderMenu')
            ->get();

        return response()->json([
            'menus' => $menus
        ]);
    }
}
