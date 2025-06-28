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

    public function getUserSectionDetailsAdd(Request $request)
    {
        $user_id    = $request->input('user_id');
        $section_id = $request->input('section_id');
        $profile_id = $request->input('profile_id');

        if (! $user_id || ! $section_id || ! $profile_id) {
            return $this->errorResponse('Missing parameters', 400);
        }

        // Step 1: Get section table name
        $section = DB::table('resource-section')->where('id', $section_id)->first();

        if (! $section) {
            return $this->errorResponse('Section not found.', 404);
        }

        $sectionTable = $section->sectionTable;
        $idColumnName = $section->idColumnName;
        $section_name = $section->sectionName;

        if (! $sectionTable || ! $idColumnName) {
            return $this->errorResponse('Section configuration is incomplete.', 400);
        }

        // Step 2: Get valid question_column_names mapping (sectionquestionid => question_column_name)
        $sectionquestionids = DB::table('section_questions')->select('sectionquestionid')

            ->where('resource_section_id', $section_id)->get()->pluck('sectionquestionid')
            ->filter(fn($name) => ! is_null($name) && trim($name) !== '')->values()->toArray();

        $questionColumnNamesAssoc = DB::table('section_questions')->whereIn('sectionquestionid', $sectionquestionids)->whereNotNull('question_column_name')->whereRaw("TRIM(question_column_name) != ''")->pluck('question_column_name', 'sectionquestionid')->toArray();

        // Step 3: Build dynamic section_data from input data array
        $inputData       = $request->input('data', []);
        $section_data    = [];
        $multiInsertRows = [];

        foreach ($questionColumnNamesAssoc as $sectionquestionid => $columnName) {
            $value                     = $inputData[$sectionquestionid] ?? null;
            $section_data[$columnName] = $value;
        }

        $insertedIds = [];

        if (! empty($multiInsertRows)) {
            foreach ($multiInsertRows as $row) {
                $insertedIds[] = DB::table($sectionTable)->insertGetId($row, $idColumnName);
            }
            $recordId = $insertedIds;
            $action   = 'inserted';
        } else {
            $section_data['id'] = $user_id;
            $recordId           = DB::table($sectionTable)->insertGetId($section_data, $idColumnName);

            $action = 'inserted';
        }

        $existingCvProfileSection = DB::table('create-cvprofilesection')
            ->where('cvid', $profile_id)
            ->where('section', $section_id)
            ->where('id', $user_id)
            ->where('status', 1)->first();

        $newRecordIds   = is_array($recordId) ? $recordId : [$recordId];
        $newRecordIds   = array_map('strval', $newRecordIds);
        $subsectionData = json_encode(array_map('strval', is_array($recordId) ? $recordId : [$recordId]));
        if ($existingCvProfileSection && $section->defaultsection == 1) {
            return $this->errorResponse('Data already Available.', 400);
        }

        if ($existingCvProfileSection && $section->defaultsection == 0) {
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
            //dd($existingCvProfileSection);
        }

        return response()->json([
            'status'        => 'success',
            'message'       => "Data {$action} successfully.",
            'record_id'     => $recordId,
            'section_table' => $sectionTable,
            'section_data'  => $section_data,
        ]);
    }

}
