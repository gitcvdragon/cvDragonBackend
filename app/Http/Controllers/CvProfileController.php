<?php
namespace App\Http\Controllers;

use App\Models\CreateCvuserprofile;
use App\Models\CvProfileSection;
use App\Traits\ApiResponseTrait;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class CvProfileController extends Controller
{
    use ApiResponseTrait;

// public function getUserProfile(Request $request)
// {
//     $userId = auth()->user()->id;

//     // Fetch user profile(s) with associated cvProfileSection
//     $profiles = CreateCvuserprofile::with('cvProfileSection')
//         ->where('id', $userId)
//         ->where('status', 1)
//         ->get();

//     // If no profiles found
//     if ($profiles->isEmpty()) {
//         return $this->successResponse(
//             ['profiles' => null],
//             'No Profiles Fetched!!'
//         );
//     }

//     // Fetch all possible sections
//     $allSections = DB::table('resource-section')
//         ->where('status', 1)
//         ->orderBy('orderSection')
//         ->get();

//     $profilesWithSections = $profiles->map(function ($profile) use ($allSections) {
//         $profileData = $profile->toArray();

//         $profileData['profile_id'] = $profile->cvid ?? null;

//         $profileData['sections'] = is_array($profile->sections)
//             ? $profile->sections
//             : json_decode($profile->sections, true);

//         $profileData['sectionOrder'] = is_array($profile->sectionOrder)
//             ? $profile->sectionOrder
//             : json_decode($profile->sectionOrder, true);

//         // Map existing user sections into an array for quick lookup
//         $existingSections = collect($profile->cvProfileSection ?? [])
//             ->mapWithKeys(function ($s) {
//                 return [(int) $s['section'] => $s];
//             });

//         // Merge all sections with user data (or fallback empty)
//         $cvProfileSection = $allSections->map(function ($section) use ($profile, $existingSections) {
//             if ($existingSections->has((int) $section->id)) {
//                 // User already has data for this section
//                 return $existingSections->get((int) $section->id);
//             }

//             // No data: return empty structure
//             return [
//                 'cvid'       => $profile->cvid,
//                 'section'    => (int) $section->id,
//                 'subsection' => [],
//                 'showName'   => $section->sectionName,
//             ];
//         })->toArray();

//         $profileData['cv_profile_section'] = $cvProfileSection;

//         return $profileData;
//     });

//     return $this->successResponse(
//         ['profiles' => $profilesWithSections],
//         'All Profiles Fetched!!'
//     );
// }


public function getUserProfile(Request $request)
{
    $userId = auth()->user()->id;

    // Fetch user profile(s) with associated cvProfileSection
    $profiles = CreateCvuserprofile::with('cvProfileSection')
        ->where('id', $userId)
        ->where('status', 1)
        ->get();

    // If no profiles found
    if ($profiles->isEmpty()) {
        return $this->successResponse(
            ['profiles' => null],
            'No Profiles Fetched!!'
        );
    }

    // Fetch all possible sections
    $allSections = DB::table('resource-section')
        ->where('status', 1)
        ->orderBy('orderSection')
        ->get();

    $profilesWithSections = $profiles->map(function ($profile) use ($allSections) {
        $profileData = $profile->toArray();

        $profileData['profile_id'] = $profile->cvid ?? null;

        // Decode sections and sectionOrder safely, default to empty arrays
        $profileData['sections'] = is_array($profile->sections)
            ? $profile->sections
            : (json_decode($profile->sections ?? '[]', true) ?: []);

        $profileData['sectionOrder'] = is_array($profile->sectionOrder)
            ? $profile->sectionOrder
            : (json_decode($profile->sectionOrder ?? '[]', true) ?: []);

        // Map existing user sections for quick lookup
        $existingSections = collect($profile->cvProfileSection ?? [])
            ->mapWithKeys(fn($s) => [(int) $s['section'] => $s]);

        // Merge all sections with user data or fallback defaults
        $cvProfileSection = $allSections->map(function ($section) use ($profile, $existingSections) {
            return $existingSections->get((int) $section->id, [
                'cvid'       => $profile->cvid,
                'section'    => (int) $section->id,
                'subsection' => [],
                'showName'   => $section->sectionName,
            ]);
        })->toArray();

        $profileData['cv_profile_section'] = $cvProfileSection;

        // Ensure sections and sectionOrder mirror cv_profile_section ids
        $profileData['sections'] = array_column($cvProfileSection, 'section');
        $profileData['sectionOrder'] = array_column($cvProfileSection, 'section');

        return $profileData;
    });



    return $this->successResponse(
        ['profiles' => $profilesWithSections],
        'All Profiles Fetched!!'
    );
}




    public function addUserProfile(Request $request)
{
    $userId = auth()->user()->id;

    $defaultSections = DB::table('resource-section')
        ->where('status', 1)
        ->orderBy('orderSection')
        ->pluck('id')
        ->map(function ($id) {
            return preg_match('/[a-zA-Z]/', $id) ? (string) $id : (int) $id;
        })
        ->toArray();

    $profile = CreateCvuserprofile::create([
        'id'           => $userId,
        'profileName'  => $request->profileName,
        'sections'     => json_encode($defaultSections),
        'sectionOrder' => json_encode($defaultSections),
    ]);

    $profileWithRelations = CreateCvuserprofile::with('cvProfileSection')
        ->where('id', $userId)
        ->where('cvid', $profile->cvid)
        ->where('status', 1)
        ->first();

    if (!$profileWithRelations) {
        return $this->successResponse(['profiles' => null], 'No Profiles Fetched!!');
    }

    $profileData = $profileWithRelations->toArray();
    $profileData['profile_id'] = $profileWithRelations->cvid ?? null;
    $profileData['sections'] = is_array($profileWithRelations->sections)
        ? $profileWithRelations->sections
        : json_decode($profileWithRelations->sections, true);

    $profileData['sectionOrder'] = is_array($profileWithRelations->sectionOrder)
        ? $profileWithRelations->sectionOrder
        : json_decode($profileWithRelations->sectionOrder, true);

    $sections = DB::table('resource-section')
        ->where('status', 1)
        ->orderBy('orderSection')
        ->get();

    $cvProfileSection = $sections->map(function ($section) use ($profile) {
        return [
            'cvid'       => $profile->cvid,
            'section'    => (int) $section->id,
            'subsection' => [],
            'showName'   => $section->sectionName,
        ];
    })->toArray();

    $profileData['cv_profile_section'] = $cvProfileSection;

    return $this->successResponse(
        ['profiles' => $profileData],
        'Profile Created and Fetched Successfully!'
    );
}


    public function updateUserProfile(Request $request)
    {
        $validatedData = $request->validate([
            'profileName' => 'nullable|string|max:255',
        ]);

        $userId  = $request->user()->id;
        $profile = CreateCvuserprofile::where('id', $userId)->where('cvid', $request->profile_id)->where('status', 1)->first();

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
                    'sectionOrder'   => $profile->sectionOrder,
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

  $sectionOrder = collect($request->sectionOrder)
    ->map(fn($id) => (string) $id)
    ->unique()
    ->values()
    ->toArray();

$profile->sectionOrder = $sectionOrder;
$profile->save();


    return $this->successResponse(
        // [
        //     'profile' => [
        //         'cvid'           => $profile->cvid,
        //         'id'             => $profile->id,
        //         'profileName'    => $profile->profileName,
        //         'sections'       => $profile->sections,
        //         'sectionOrder'   => $sectionOrder, // Already parsed
        //         'design'         => $profile->design,
        //         'font'           => $profile->font,
        //         'setting'        => $profile->setting,
        //         'isPublic'       => $profile->isPublic,
        //         'progressReport' => $profile->progressReport,
        //         'dateUpdated'    => $profile->dateUpdated,
        //         'status'         => $profile->status,
        //     ],
        // ],null,
        null,
        'Section Order Updated Successfully!!'
    );
}

    public function deleteUserProfile(Request $request)
    {
        $userId  = $request->user()->id;
        $profile = CreateCvuserprofile::where('id', $userId)->where('cvid', $request->profile_id)->where('status', 1)->first();

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
        // $user_id    = $request->input('user_id');
         $user_id = auth()->user()->id;


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


if ($existingCvProfileSection) {
            if ($defaultSection == 0){
				//($existingCvProfileSection);
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
            }else{
				 DB::table('create-cvprofilesection')
                    ->where('cvid', $profile_id)
                    ->where('section', $section_id)
                    ->where('id', $user_id)
                    ->where('status', 1)
                    ->update([
                        'subsection' => json_encode($newRecordIds),
                    'showName'   => $section_name,
                    ]);

			}
}else{
   DB::table('create-cvprofilesection')->insert([
        'cvid'       => $profile_id,
        'section'    => $section_id,
        'id'         => $user_id,
        'subsection' => json_encode($newRecordIds),
        'showName'   => $section_name,
        'status'     => 1,
        'dateCreated' => now(),
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
