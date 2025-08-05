<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\{CreateCvuserprofile, CvImages, CvInterest, CvLanguages, CVSkill, CvTechnical, User};
use App\Services\UserService;
use App\Traits\ApiResponseTrait;
use Illuminate\Support\Facades\Validator;

class UserController extends Controller
{
    use ApiResponseTrait;
    protected UserService $userService;

    public function __construct(UserService $userService)
    {
        $this->userService = $userService;
    }

    //This API updates the authenticated user's name and gender in both the users and user_basic tables. It validates that both fields are provided and valid, and returns a success message upon completion. The request must include a valid Bearer token for authentication.
    public function updateNameAndGender(Request $request)
    {
        $validator = Validator::make(
            $request->all(),
            [
                'name' => 'required|string|max:100',
                'gender' => 'required|in:male,female,other',
            ],
            [
                'name.required' => 'Name is required.',
                'gender.required' => 'Gender is required.',
                'gender.in' => 'Gender must be one of: male, female, or other.',
            ],
        );

        if ($validator->fails()) {
            return response()->json(
                [
                    'status' => false,
                    'message' => 'Validation failed.',
                    'errors' => $validator->errors()->first(),
                ],
                422,
            );
        }

        $user = auth()->user();

        // Update users table
        $user->username = $request->name;
        $user->gender = $request->gender;
        $user->save();

        // Update user_basic table
        if ($user->userBasic) {
            $user->userBasic->fullName = $request->name;
            $user->userBasic->gender = $request->gender;
            $user->userBasic->save();
        }

         if ($user->cvBasicInfo) {
            $user->cvBasicInfo->cvFullName = $request->name;
            $user->cvBasicInfo->gender = $request->gender;
            $user->cvBasicInfo->save();
        }

        return response()->json([
            'status' => true,
            'message' => 'Name and gender updated successfully.',
        ]);
    }

    //This API allows an authenticated user to upload a profile image. The image is stored in the public disk, associated with the user in the cv_images table, and linked to the user's CV profile in the create_cvuserprofiles table. The image must be a JPEG or PNG and not exceed 2MB in size.
    public function uploadProfileImage(Request $request)
    {
        $request->validate(
            [
                'image' => 'required|image|mimes:jpeg,png,jpg|max:2048',
            ],
            [
                'image.required' => 'Profile image is required.',
                'image.image' => 'The uploaded file must be an image.',
                'image.mimes' => 'Only jpeg, png, and jpg images are allowed.',
                'image.max' => 'Image size should not exceed 2MB.',
            ],
        );

        $user = auth()->user();

        // Upload image
        $path = $request->file('image')->store('profile_image', 'public');

        // Save or update image record
        $cvImage = CvImages::updateOrCreate(['user_id' => $user->id], ['image' => $path]);
        CreateCvuserprofile::updateOrCreate(['profilePicture' => $cvImage->id], ['user_id' => $user->id]);

        return response()->json([
            'status' => true,
            'message' => 'Profile image uploaded successfully.',
        ]);
    }

    public function userSkillTechnicalLangInterestStore(Request $request)
    {
        $validator = Validator::make(
            $request->all(),
            [
                'skills' => 'nullable|array',
                'skills.*' => 'string|max:255',

                'technical_skills' => 'nullable|array',
                'technical_skills.*' => 'string|max:255',

               'languages' => 'nullable|array',
                'languages.*' => 'string|max:255',
                'readLanguage' => 'nullable|array',
                'writeLanguage' => 'nullable|array',
                'speakLanguage' => 'nullable|array',

                'interests' => 'nullable|array',
                'interests.*' => 'string|max:255',
            ],
            [
                'skills.*.string' => 'Each skill must be a string.',
                'technical_skills.*.string' => 'Each technical skill must be a string.',
                'languages.*.string' => 'Each language must be a string.',
                'interests.*.string' => 'Each interest must be a string.',
            ],
        );

        if ($validator->fails()) {
            return response()->json(
                [
                    'status' => false,
                    'message' => 'Validation failed.',
                    'errors' => $validator->errors(),
                ],
                422,
            );
        }

        $user = auth()->user();

        // Store Skills
        if (!empty($request->skills)) {
            foreach ($request->skills as $skill) {
                CVSkill::create([
                    'user_id' => $user->id,
                    'skill' => $skill,
                ]);
            }
        }

        // Store Technical Skills
        if (!empty($request->technical_skills)) {
            foreach ($request->technical_skills as $tech) {
                CvTechnical::create([
                    'user_id' => $user->id,
                    'technical' => $tech,
                ]);
            }
        }

        // Store Languages
        if (!empty($request->languages)) {
            foreach ($request->languages as $index => $lang) {
                CvLanguages::create([
                    'user_id' => $user->id,
                    'language' => $lang,
                    'readLanguage' => $request->readLanguage[$index],
                    'writeLanguage' => $request->writeLanguage[$index],
                    'speakLanguage' => $request->speakLanguage[$index],
                ]);
            }
        }

        // Store Interests
        if (!empty($request->interests)) {
            foreach ($request->interests as $interest) {
                CvInterest::create([
                    'user_id' => $user->id,
                    'interest' => $interest,
                ]);
            }
        }

        return response()->json([
            'status' => true,
            'message' => 'Skills, technical skills, languages, and interests saved successfully.',
        ]);
    }

}
