<?php

namespace App\Http\Controllers\Api\website;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Traits\ApiResponseTrait;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class DigitalCvController extends Controller
{
    use ApiResponseTrait;

    public function createDigitalCv(Request $request)
    {
        try {
            $id = auth()->id();
            $user = UserBasic::findOrFail($id);

            $user->update([

                'username'   => $request->username,
            ]);



            $user = UserBasic::findOrFail($id);

            if ($request->filled('profileImageUrl')) {
                $user->profileImageUrl = $request->profileImageUrl;
            }
            if ($request->filled('profileVideoURL')) {
                $user->profileVideoURL = $request->profileVideoURL;
            }
            if ($request->filled('publicProfileStatus')) {
                $user->publicProfileStatus = $request->publicProfileStatus;
            }
            if ($request->filled('publicProfile')) {
                $user->publicProfile = $request->publicProfile;
            }
            if ($request->filled('publicProfileDesign')) {
                $user->publicProfileDesign = $request->publicProfileDesign;
            }


            if ($request->filled('showMobile')) {
                $user->showMobile = $request->showMobile;
            }
            if ($request->filled('showProfile')) {
                $user->showProfile = $request->showProfile;
            }
            if ($request->filled('showEmail')) {
                $user->showEmail = $request->showEmail;
            }

            $user->save();

            return $this->successResponse(
                ['user' => $user],
                'Data updated successfully!'
            );

        } catch (\Exception $e) {
            return $this->errorResponse(
                'Something went wrong! ' . $e->getMessage(),
                500
            );
        }
    }

    public function showDigitalCv(Request $request)
    {
        try {
            $id = auth()->id();

            $user = UserBasic::findOrFail($id);

            $user->showProfile = $user->showProfile == 1 ? 0 : 1;

            $user->save();

            return $this->successResponse(
                ['user' => $user],
                'Profile visibility toggled successfully!'
            );

        } catch (\Exception $e) {
            return $this->errorResponse(
                'Something went wrong! ' . $e->getMessage(),
                500
            );
        }
    }


}
