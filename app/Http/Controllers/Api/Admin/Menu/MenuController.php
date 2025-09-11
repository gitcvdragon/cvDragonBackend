<?php

namespace App\Http\Controllers\Api\Admin\Menu;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Tymon\JWTAuth\Facades\JWTAuth;
use Illuminate\Support\Facades\Hash;
class MenuController extends Controller
{



    public function login(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'password' => 'required|string|min:6',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 422);
        }

        // Fetch admin using DB query
        $admin = DB::table('admin_users')->where('email', $request->email)->first();

        if (!$admin || !Hash::check($request->password, $admin->password)) {
            return response()->json(['error' => 'Invalid credentials'], 401);
        }

        // Create JWT token using admin id
        $token = JWTAuth::fromUser((object)[
            'id' => $admin->id,
            'fullName' => $admin->fullName,
            'email' => $admin->email,
            'role_id' => $admin->role_id,
        ]);

        return response()->json([
            'success' => true,
            'token' => $token,
            'admin' => [
                'id' => $admin->id,
                'fullName' => $admin->fullName,
                'email' => $admin->email,
                'role_id' => $admin->role_id
            ]
        ]);
    }

public function logout(Request $request)
{
    Auth::guard('admin')->logout();

    return response()->json([
        'success' => true,
        'message' => 'Logged out successfully'
    ]);
}
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
