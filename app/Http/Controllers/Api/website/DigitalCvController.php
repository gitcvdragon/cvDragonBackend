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

            // Always update username
            \DB::table('user-basic')
                ->where('id', $id)
                ->update([
                    'username' => $request->username,
                ]);

            // Build update data dynamically
            $updateData = [];

            if ($request->filled('profileImageUrl')) {
                $updateData['profileImageUrl'] = $request->profileImageUrl;
            }
            if ($request->filled('profileVideoURL')) {
                $updateData['profileVideoURL'] = $request->profileVideoURL;
            }
            if ($request->filled('publicProfileStatus')) {
                $updateData['publicProfileStatus'] = $request->publicProfileStatus;
            }
            if ($request->filled('publicProfile')) {
                $updateData['publicProfile'] = $request->publicProfile;
            }
            if ($request->filled('publicProfileDesign')) {
                $updateData['publicProfileDesign'] = $request->publicProfileDesign;
            }
            if ($request->filled('showMobile')) {
                $updateData['showMobile'] = $request->showMobile;
            }
            if ($request->filled('showProfile')) {
                $updateData['showProfile'] = $request->showProfile;
            }
            if ($request->filled('showEmail')) {
                $updateData['showEmail'] = $request->showEmail;
            }

            // Update DB if there’s anything to update
            if (!empty($updateData)) {
                \DB::table('user-basic')
                    ->where('id', $id)
                    ->update($updateData);
            }

            // Get updated user
            $user = \DB::table('user-basic')->where('id', $id)->first();

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
