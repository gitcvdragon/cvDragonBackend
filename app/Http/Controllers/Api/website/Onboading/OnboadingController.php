<?php

namespace App\Http\Controllers\Api\website\Onboading;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Traits\ApiResponseTrait;
use Illuminate\Support\Facades\Validator;

class OnboadingController extends Controller
{
    use ApiResponseTrait;

    public function updateProfile(Request $request)
    {
        $userId = auth()->user()->id;

        // Validate input
        $validator = Validator::make($request->all(), [
            'fullName' => 'nullable|string|max:100',
            'gender' => 'nullable|string|in:Male,Female,Other',
            'profile_type' => 'nullable|string|max:100',
            'wizardEducationSpecialization' => 'nullable|string|max:255',
            'wizardEducationProfile' => 'nullable|string|max:255',
            'wizardWorkProfile' => 'nullable|string|max:255',
            'wizardWorkSpecialization' => 'nullable|string|max:255',
            'wizardWorkExp' => 'nullable|integer',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 400);
        }

        // Prepare update data dynamically
        $updateData = array_filter([
          //  'fullName' => $request->input('fullName'),
           // 'gender' => $request->input('gender'),
            'profile_type' => $request->input('profile_type'),
            'wizardEducationProfile' => $request->input('wizardEducationProfile'),
            'wizardEducationSpecialization' => $request->input('wizardEducationSpecialization'),
            'wizardWorkProfile' => $request->input('wizardWorkProfile'),
            'wizardWorkSpecialization' => $request->input('wizardWorkSpecialization'),
            'wizardWorkExp' => $request->input('wizardWorkExp'),
            'dateUpdated' => now(),
        ], function ($value) {
            return !is_null($value);
        });

        // Update user record
        DB::table('user-basic')
            ->where('id', $userId)
            ->update($updateData);

        return $this->successResponse([
            'userId' => $userId
        ], 'User profile updated successfully');
    }


    public function onboardProfile(Request $request)
    {
        $userId = auth()->user()->id;

        // Validate input
        $validator = Validator::make($request->all(), [
            'fullName' => 'nullable|string|max:100',
            'gender' => 'nullable|string|in:Male,Female,Other',
            'userName' => 'nullable|string|max:100',
            'profile_type' => 'nullable|string|max:100',
            'wizardEducationSpecialization' => 'nullable|string|max:255',
            'wizardEducationProfile' => 'nullable|string|max:255',
            'wizardWorkProfile' => 'nullable|string|max:255',
            'wizardWorkSpecialization' => 'nullable|string|max:255',
            'wizardWorkExp' => 'nullable|integer',
            'skills' => 'nullable|array',
            'technicalSkills' => 'nullable|array',
            'interests' => 'nullable|array',
            'languages' => 'nullable|array', // each element: ['language' => '', 'read' => 1, 'write' => 1, 'speak' => 1]
            // Section IDs for CV profile sections
            'softskill_id' => 'nullable|integer',
            'technicalskill_id' => 'nullable|integer',
            'interest_id' => 'nullable|integer',
            'language_id' => 'nullable|integer',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 400);
        }

        // ------------------------
        // Update user-basic table
        // ------------------------
        $updateUserBasic = array_filter([
            'fullName' => $request->input('fullName'),
           // 'gender' => $request->input('gender'),
            'profile_type' => $request->input('profile_type'),
            'wizardEducationProfile' => $request->input('wizardEducationProfile'),
            'wizardEducationSpecialization' => $request->input('wizardEducationSpecialization'),
            'wizardWorkProfile' => $request->input('wizardWorkProfile'),
            'wizardWorkSpecialization' => $request->input('wizardWorkSpecialization'),
            'wizardWorkExp' => $request->input('wizardWorkExp'),
            'dateUpdated' => now(),
        ], fn($value) => !is_null($value));

        DB::table('user-basic')->where('id', $userId)->update($updateUserBasic);

        // ------------------------
        // Update users table
        // ------------------------
        $updateUsers = array_filter([
            'userName' => $request->input('fullName'),
            'gender' => $request->input('gender'),
        ], fn($value) => !is_null($value));

        DB::table('users')->where('id', $userId)->update($updateUsers);

        // ------------------------
        // Helper function to insert into CV profile section
        // ------------------------
        $insertCvProfileSection = function ($cvid, $showName, $sectionId, $subsectionIds) use ($userId) {
            if ($subsectionIds && $sectionId) {
                DB::table('create-cvprofilesection')->insert([
                    'cvid' => $cvid,
                    'id' => $userId,
                    'showName' => $showName,
                    'section' => $sectionId,
                    'subsection' => json_encode($subsectionIds),
                    'dateCreated' => now(),
                    'status' => 1,
                ]);
            }
        };

        // ------------------------
        // Fetch first CV profile ID for user
        // ------------------------
        $cvid = DB::table('create-cvprofile')->where('id', $userId)->orderBy('cvid', 'asc')->value('cvid');

        // ------------------------
        // Insert Skills
        // ------------------------
        $skillsIds = [];
        if ($request->filled('skills')) {
            foreach ($request->input('skills') as $skill) {
                $skill = trim($skill);
                if (!$skill) continue;

                $exists = DB::table('cv-skills')
                    ->where('refID', $userId)
                    ->where('skill', $skill)
                    ->where('status', 1)
                    ->exists();

                if (!$exists) {
                    $id = DB::table('cv-skills')->insertGetId([
                        'skill' => $skill,
                        'refID' => $userId,
                        'created' => now(),
                        'status' => 1,
                    ]);
                    $skillsIds[] = $id;
                }
            }

            // Add to CV profile section
            $insertCvProfileSection($cvid, 'Soft Skills', $request->softskill_id, $skillsIds);
        }

        // ------------------------
        // Insert Technical Skills
        // ------------------------
       // Technical Skills
$technicalIds = [];
if ($request->filled('technicalSkills')) {
    foreach ($request->input('technicalSkills') as $techSkill) {
        $techSkill = trim($techSkill);
        if (!$techSkill) continue;

        $exists = DB::table('cv-technical')
            ->where('refID', $userId)
            ->where('technical', $techSkill)
            ->where('status', 1)
            ->exists();

        if (!$exists) {
            $id = DB::table('cv-technical')->insertGetId([
                'technical' => $techSkill,
                'refID' => $userId,
                'created' => now(),
                'status' => 1,
            ]);
            $technicalIds[] = $id;
        }
    }

    $insertCvProfileSection($cvid, 'Technical Skills', $request->technicalskill_id, $technicalIds);
}

// Interests
$interestIds = [];
if ($request->filled('interests')) {
    foreach ($request->input('interests') as $interest) {
        $interest = trim($interest);
        if (!$interest) continue;

        $exists = DB::table('cv-interests')
            ->where('refID', $userId)
            ->where('interest', $interest)
            ->where('status', 1)
            ->exists();

        if (!$exists) {
            $id = DB::table('cv-interests')->insertGetId([
                'interest' => $interest,
                'refID' => $userId,
                'created' => now(),
                'status' => 1,
            ]);
            $interestIds[] = $id;
        }
    }

    $insertCvProfileSection($cvid, 'Interests', $request->interest_id, $interestIds);
}

// Languages
$languageIds = [];
if ($request->filled('languages')) {
    foreach ($request->input('languages') as $lang) {
        $language = trim($lang['language'] ?? '');
        $read = $lang['read'] ?? 0;
        $write = $lang['write'] ?? 0;
        $speak = $lang['speak'] ?? 0;

        if (!$language) continue;

        $exists = DB::table('cv-languages')
            ->where('refID', $userId)
            ->where('language', $language)
            ->where('status', 1)
            ->exists();

        if (!$exists) {
            $id = DB::table('cv-languages')->insertGetId([
                'language' => $language,
                'readLanguage' => $read,
                'writeLanguage' => $write,
                'speakLanguage' => $speak,
                'refID' => $userId,
                'created' => now(),
                'status' => 1,
            ]);
            $languageIds[] = $id;
        }
    }

    $insertCvProfileSection($cvid, 'Spoken Languages', $request->language_id, $languageIds);
}


        return $this->successResponse([
            'userId' => $userId
        ], 'User profile updated successfully with skills, technical skills, interests, and languages.');
    }


}
