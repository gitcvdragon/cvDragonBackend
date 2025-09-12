<?php

namespace App\Http\Controllers\Api\Admin\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;

use Tymon\JWTAuth\Facades\JWTAuth;
use Tymon\JWTAuth\Facades\JWTFactory;
use Illuminate\Support\Facades\DB;

class AuthController extends Controller
{


public function login(Request $request)
{
    // Validate input
    $validator = Validator::make($request->all(), [
        'email'    => 'required|email',
        'password' => 'required|string|min:6',
    ]);

    if ($validator->fails()) {
        return response()->json(['error' => $validator->errors()->first()], 422);
    }

    // Fetch admin from DB
    $admin = DB::table('admin_users')->where('email', $request->email)->first();



    try {
        $customClaims = [
            'sub'     => $admin->id,
            'email'   => $admin->email,
            'role_id' => $admin->role_id,
            'iat'     => now()->timestamp,
            'exp'     => now()->addHours(24)->timestamp,
        ];

        $payload = JWTFactory::customClaims($customClaims)->make();

        $token = JWTAuth::encode($payload)->get();
    } catch (\Exception $e) {
        return response()->json([
            'error'   => 'Could not create token',
            'message' => $e->getMessage(),
        ], 500);
    }

    return response()->json([
        'success' => true,
        'token'   => $token,
        'admin'   => [
            'id'       => $admin->id,
            'fullName' => $admin->fullName ?? null,
            'email'    => $admin->email,
            'role_id'  => $admin->role_id,
        ],
    ]);
}


    public function logout(Request $request)
    {
		//dd($request->all());
        try {
            JWTAuth::invalidate(JWTAuth::getToken());
            return response()->json([
                'success' => true,
                'message' => 'Logged out successfully',
            ]);
        } catch (JWTException $e) {
            return response()->json(['error' => 'Failed to logout, token invalid'], 500);
        }
    }
}
