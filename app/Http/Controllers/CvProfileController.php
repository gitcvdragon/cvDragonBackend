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
            [
                'profile' => [
                    'cvid'           => $profile->cvid,
                    'id'             => $profile->id,
                    'profileName'    => $profile->profileName,
                    'sections'       => $profile->sections,
                    'sectionOrder'   => json_decode($profile->sectionOrder, true),
                    'design'         => $profile->design,
                    'font'           => $profile->font,
                    'setting'        => $profile->setting,
                    'isPublic'       => $profile->isPublic,
                    'progressReport' => $profile->progressReport,
                    'dateUpdated'    => $profile->dateUpdated,
                    'status'         => $profile->status,
                ],
            ],
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
            [
                'profile' => [
                    'cvid'           => $profile->cvid,
                    'id'             => $profile->id,
                    'profileName'    => $profile->profileName,
                    'sections'       => $profile->sections,
                    'sectionOrder'   => json_decode($profile->sectionOrder, true),
                    'design'         => $profile->design,
                    'font'           => $profile->font,
                    'setting'        => $profile->setting,
                    'isPublic'       => $profile->isPublic,
                    'progressReport' => $profile->progressReport,
                    'dateUpdated'    => $profile->dateUpdated,
                    'status'         => $profile->status,
                ],
            ],
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

        //  $profile->delete();

        return $this->successResponse(
            null,
            'Profile and related sections marked as inactive successfully!!'
        );
    }

    public function addData(Request $request)
    {
        $recordId   = $request->input('record_id');
        $profile_id = $request->input('profile_id');
        $section_id = $request->input('section_id');
        $user_id    = $request->input('user_id');

        if (! $recordId || ! $profile_id || ! $section_id || ! $user_id) {
            return $this->errorResponse('Missing parameters', 400);
        }

        try {
            DB::beginTransaction();

            $section = DB::table('resource-section')->where('id', $section_id)->first();

            if (! $section) {
                DB::rollBack();
                return $this->errorResponse('Section not found.', 404);
            }

            $section_name   = $section->sectionName;
            $defaultSection = $section->defaultsection;

            $existingCvProfileSection = DB::table('create-cvprofilesection')
                ->where('cvid', $profile_id)
                ->where('section', $section_id)
                ->where('id', $user_id)
                ->where('status', 1)
                ->first();

            $newRecordIds = [strval($recordId)];

            if ($existingCvProfileSection && $defaultSection == 1) {
                DB::rollBack();
                return $this->errorResponse('Data already available.', 400);
            }

            if ($existingCvProfileSection && $defaultSection == 0) {
                $existingSubsection = json_decode($existingCvProfileSection->subsection, true) ?? [];
                $existingSubsection = array_map('strval', $existingSubsection);
                $mergedSubsection   = array_unique(array_merge($existingSubsection, $newRecordIds));

                DB::table('create-cvprofilesection')
                    ->where('cvid', $profile_id)
                    ->where('section', $section_id)
                    ->where('id', $user_id)
                    ->where('status', 1)
                    ->update([
                        'subsection' => json_encode($mergedSubsection),
                        'showName'   => $section_name,
                    ]);
            } else {
                DB::table('create-cvprofilesection')->insert([
                    'cvid'       => $profile_id,
                    'section'    => $section_id,
                    'id'         => $user_id,
                    'subsection' => json_encode($newRecordIds),
                    'showName'   => $section_name,
                ]);
            }

            DB::commit();

            return response()->json([
                'status'    => 'success',
                'message'   => 'Section data linked successfully.',
                'record_id' => $recordId,
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse('An error occurred: ' . $e->getMessage(), 500);
        }
    }

}
