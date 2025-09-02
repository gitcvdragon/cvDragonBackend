<?php

namespace App\Http\Controllers\Api\website;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Traits\ApiResponseTrait;
use App\Models\{CreateCvuserprofile, CvImages, CvInterest, CvLanguages, CVSkill, CvTechnical, User};

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class DigitalCvController extends Controller
{
    use ApiResponseTrait;


    public function createDigitalCv(Request $request)
    {
        try {
            $id = auth()->id();

            $validator = Validator::make($request->all(), [
                'username'            => 'required|string|max:255',
                'profileImageUrl'     => 'nullable|url',
                'profileVideoURL'     => 'nullable|url',
                'publicProfileStatus' => 'nullable|in:0,1',
                'publicProfile'       => 'nullable|max:255',
                'publicProfileDesign' => 'nullable|max:255',
                'showMobile'          => 'nullable|in:0,1',
                'showProfile'         => 'nullable|in:0,1',
                'showEmail'           => 'nullable|in:0,1',
            ]);

            if ($validator->fails()) {
                return $this->errorResponse($validator->errors()->first(), 422);
            }

            \DB::table('users')
                ->where('id', $id)
                ->update([
                    'username' => $request->username,
                ]);

            $updateData = $request->only([
                'profileImageUrl',
                'profileVideoURL',
                'publicProfileStatus',
                'publicProfile',
                'publicProfileDesign',
                'showMobile',
                'showProfile',
                'showEmail',
            ]);

            if (!empty($updateData)) {
                \DB::table('user-basic')
                    ->where('id', $id)
                    ->update($updateData);
            }

            $user = \DB::table('user-basic')->where('id', $id)->first();

            return $this->successResponse(
                // ['user' => $user],
                [],
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

            $user = \DB::table('user-basic')->where('id', $id)->first();
            if (!$user) {
                return $this->errorResponse('User not found', 404);
            }

            // Toggle the value
            $newValue = $user->showProfile == 1 ? 0 : 1;

            // Update in DB
            \DB::table('user-basic')
                ->where('id', $id)
                ->update(['showProfile' => $newValue]);

            // Reflect the new value in response
            $user->showProfile = $newValue;

            return $this->successResponse(
                [],
                'Profile visibility toggled successfully!'
            );

        } catch (\Exception $e) {
            return $this->errorResponse(
                'Something went wrong! ' . $e->getMessage(),
                500
            );
        }
    }


    public function showallDigitalCv(Request $request)
    {
        try {
            $id = auth()->id();

            $user = \DB::table('user-basic')->where('id', $id)->first();
            if (!$user) {
                return $this->errorResponse('User not found', 404);
            }

            $validator = Validator::make($request->all(), [
                'showMobile' => 'nullable|in:0,1',
                'showProfile' => 'nullable|in:0,1',
                'showEmail' => 'nullable|in:0,1',
            ]);

            if ($validator->fails()) {
                return $this->errorResponse($validator->errors()->first(), 422);
            }

            $updates = $validator->validated();

            if (empty($updates)) {
                return $this->errorResponse('No valid fields provided to update', 400);
            }

            \DB::table('user-basic')
                ->where('id', $id)
                ->update($updates);

            return $this->successResponse(
               [],
                'Profile visibility updated successfully!'
            );

        } catch (\Exception $e) {
            return $this->errorResponse(
                'Something went wrong! ' . $e->getMessage(),
                500
            );
        }
    }
    public function DigitalCv(Request $request, $userId)
    {
        // Fetch user
        $user = \DB::table('user-basic')->where('id', $userId)->first();

        if (!$user) {
            return $this->errorResponse('User not found', 404);
        }

        // Check if public profile is enabled
        if ($user->publicProfileStatus != 1) {
            return $this->errorResponse('User profile is not public', 403);
        }

        // Build query based on publicProfile field
        $profileQuery = CreateCvuserprofile::with('cvProfileSection')
            ->where('status', 1);

        if (!empty($user->publicProfile)) {
            $profileQuery->where('cvid', $user->publicProfile);

        } else {
            $profileQuery->where('id', $userId);

        }

        // Get profiles
        $profiles = $profileQuery->get();

        if ($profiles->isEmpty()) {
            return $this->successResponse(
                ['profiles' => null],
                'No Profiles Fetched!!'
            );
        }

        // Transform profiles
        $profilesWithSections = $profiles->map(function ($profile) {
            $profileData = $profile->toArray();

            $profileData['profile_id'] = $profile->cvid ?? null;
           $profileData['showMobile']    =$user->showMobile;
         $profileData['showEmail']  =$user->showEmail;

            $profileData['sections'] = is_array($profile->sections)
                ? $profile->sections
                : json_decode($profile->sections, true);

            $profileData['sectionOrder'] = is_array($profile->sectionOrder)
                ? $profile->sectionOrder
                : json_decode($profile->sectionOrder, true);

            return $profileData;
        });

        return $this->successResponse(
            ['profiles' => $profilesWithSections],
            'All Profiles Fetched!!'
        );
    }
}
