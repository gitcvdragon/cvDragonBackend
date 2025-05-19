<?php

namespace App\Http\Controllers;

use App\Models\CreateCvuserprofile;
use App\Models\ResourceSection;
use App\Traits\ApiResponseTrait;
use Illuminate\Http\Request;

class CvProfileController extends Controller
{
    use ApiResponseTrait;
    public function getUserProfile(Request $request)
    {
        $userId = $request->id;
        $profiles = CreateCvuserprofile::where('id', $userId)->where('status', 1)->get();

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
            $profileData = $profile->toArray();

            $sectionIds = is_array($profile->sections) ? $profile->sections : json_decode($profile->sections, true);

            $sections = ResourceSection::whereIn('id', $sectionIds ?? [])->get();

            $profileData['sections'] = $sections;

            return $profileData;
        });
        return $this->successResponse(
            [
                'profiles' => $profilesWithSections,
            ],
            'All Profiles Fetched!!',
        );
    }
}
