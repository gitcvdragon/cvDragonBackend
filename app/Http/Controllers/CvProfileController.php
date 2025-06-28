<?php
namespace App\Http\Controllers;

use App\Models\CreateCvuserprofile;
use App\Models\CvProfileSection;
use App\Traits\ApiResponseTrait;
use Illuminate\Http\Request;

class CvProfileController extends Controller
{
    use ApiResponseTrait;
    public function getUserProfile(Request $request)
    {
        $userId   = $request->id;
        $profiles = CreateCvuserprofile::with('cvProfileSection')->where('id', $userId)->where('status', 1)->get();

        if ($profiles->isEmpty()) {
            return $this->successResponse(
                [
                    'profiles' => null,
                ],
                'No Profiles Fetched!!',
            );
        }

        // Extract section IDs from JSON field (assumed)
        $profilesWithSections = $profiles->map(function ($profile) {
            $profileData               = $profile->toArray();
            $profileData['profile_id'] = $profile->cvid ?? null;
            $sectionIds                = is_array($profile->sections) ? $profile->sections : json_decode($profile->sections, true);

            // $sections = ResourceSection::whereIn('id', $sectionIds ?? [])->get();

            //  $profileData['sections'] = $sections;

            return $profileData;
        });
        return $this->successResponse(
            [
                'profiles' => $profilesWithSections,
            ],
            'All Profiles Fetched!!',
        );
    }

    public function addUserProfile(Request $request)
    {
        $userId = auth()->user()->id;

        $profile = CreateCvuserprofile::create([
            'id'          => $userId,
            'profileName' => $request->profileName,
        ]);

        $profiles = CreateCvuserprofile::with('cvProfileSection')->where('id', $userId)->where('cvid', $profile->cvid)->where('status', 1)->get();

        if ($profiles->isEmpty()) {
            return $this->successResponse(
                [
                    'profiles' => null,
                ],
                'No Profiles Fetched!!',
            );
        }

        $profilesWithSections = $profiles->map(function ($profile) {
            $profileData               = $profile->toArray();
            $profileData['profile_id'] = $profile->cvid ?? null;
            $sectionIds                = is_array($profile->sections) ? $profile->sections : json_decode($profile->sections, true);

            // $sections = ResourceSection::whereIn('id', $sectionIds ?? [])->get();

            //  $profileData['sections'] = $sections;

            return $profileData;
        });

        return $this->successResponse(
            [
                'profile' => $profiles,
            ],
            'Profile Created Successfully!!',
        );
    }

    public function updateUserProfile(Request $request)
    {
        $validatedData = $request->validate([
            'profileName' => 'nullable|string|max:255',
        ]);

        $userId  = $request->user()->id;
        $profile = CreateCvuserprofile::where('id', $userId)->where('status', 1)->first();

        if (! $profile) {
            return $this->errorResponse('Profile not found.', 404);
        }

        $profile->update([
            'profileName' => $request->profileName,
        ]);

        return $this->successResponse(
            ['profile' => $profile],
            'Profile Updated Successfully!!'
        );
    }

    public function updateUserProfileSectionOrderUpdate(Request $request)
    {
        $validatedData = $request->validate([
            'sectionOrder' => 'nullable|array',
        ]);

        $userId = $request->user()->id;

        $profile = CreateCvuserprofile::where('id', $userId)->where('status', 1)->first();

        if (! $profile) {
            return $this->errorResponse('Profile not found.', 404);
        }

        $sectionOrder = $request->sectionOrder;
        if (is_array($sectionOrder)) {
            $sectionOrder = json_encode($sectionOrder);
        }

        $profile->update([
            'sectionOrder' => $sectionOrder,
        ]);

        return $this->successResponse(
            ['profile' => $profile],
            'Section Order Updated Successfully!!'
        );
    }

    public function deleteUserProfile(Request $request)
    {
        $userId  = $request->user()->id;
        $profile = CreateCvuserprofile::where('id', $userId)->where('status', 1)->first();

        if (! $profile) {
            return $this->errorResponse('Profile not found.', 404);
        }

        $cvId = $profile->cvid ?? null;

        if ($cvId) {
            CvProfileSection::where('cvid', $cvId)->update(['status' => 0]);
            CreateCvuserprofile::where('cvid', $cvId)->update(['status' => 0]);
        }

        $profile->delete();

        return $this->successResponse(
            null,
            'Profile and related sections marked as inactive successfully!!'
        );
    }

}
