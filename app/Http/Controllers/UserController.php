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

    // public function createUser(Request $request)
    // {
    //     $validator = Validator::make($request->all(), [
    //         'contents' => 'required|array',
    //         'contents.fullName' => 'required|string|max:255',
    //         'contents.emailAddress' => 'required|email|unique:users,userEmail',
    //         'phoneNumber' => 'required|digits:10',
    //         'countryCode' => 'required|string|max:5',
    //         'sectionType' => 'nullable|integer',
    //         'affiliateID' => 'nullable|string|max:255',
    //         'socialType' => 'required|integer|in:0,1,2',
    //         'socialid' => 'required|string|max:255',
    //         'playerID' => 'nullable|string|max:255',
    //         'location' => 'required|string|max:255',
    //         'fullAddress' => 'required|string|max:500',
    //     ]);

    //     if ($validator->fails()) {
    //         return $this->validationErrorResponse($validator->errors()->first(), 'Validation failed!!');
    //     }

    //     $data = $validator->validated();

    //     DB::beginTransaction();

    //     try {
    //         $data = $request->all();

    //         $id = now()->timestamp . rand(1, 1000);
    //         $userauthKey = md5(microtime() . rand());
    //         $date = now()->toDateTimeString();
    //         $profileName = 'First Profile';

    //         $contents = $data['contents'];
    //         $fullName = ucwords(strtolower($contents['fullName'] ?? ''));
    //         $email = $contents['emailAddress'] ?? null;
    //         $phone = $data['phoneNumber'] ?? null;
    //         $countryCode = $data['countryCode'] ?? '';
    //         $userPhone = $phone ? $countryCode . $phone : null;
    //         $sectionType = $data['sectionType'] ?? 0;
    //         $sections = $this->userService->getSectionsByType($sectionType);

    //         User::create([
    //             'id' => $id,
    //             'categoryid' => 1,
    //             'affiliateID' => $data['affiliateID'] ?? null,
    //             'appLogin' => Carbon::now(),
    //             'socialType' => $data['socialType'],
    //             'socialid' => $data['socialid'],
    //             'authKey' => $userauthKey ?? null,
    //             'username' => $id,
    //             'playerID' => $data['playerID'],
    //             'userEmail' => $email,
    //             'usermobile' => $userPhone,
    //             'status' => 1,
    //             'dateUpdated' => Carbon::now(),
    //         ]);

    //         DB::table('user-basic')->insert([
    //             'id' => $id,
    //             'fullName' => $fullName ?? null,
    //             'emailAddress' => $email ?? null,
    //             'countryCode' => $countryCode ?? null,
    //             'phoneNumber' => $phone ?? null,
    //             'profileImageUrl' => '',
    //             'dateCreated' => $date,
    //             'status' => 1,
    //         ]);

    //         DB::table('cv-contact')->insert([
    //             'id' => $id,
    //             'phoneNumber' => $phone ?? null,
    //             'emailAddress' => $email ?? null,
    //             'location' => $data['location'] ?? null,
    //             'fullAddress' => $data['fullAddress'] ?? null,
    //             'status' => 1,
    //         ]);

    //         DB::table('cv-preference')->insert(['id' => $id, 'status' => 1]);
    //         DB::table('cv-basic-info')->insert(['id' => $id, 'cvFullName' => $fullName, 'status' => 1]);
    //         DB::table('cv-introduction')->insert(['id' => $id, 'status' => 1]);

    //         $educationRefMap = [
    //             'classX' => 1,
    //             'classXII' => 2,
    //             'graduation' => 3,
    //             'diploma' => 4,
    //         ];

    //         $educationLevels = $data['educationLevels'] ?? [];

    //         $educationEntries = collect($educationLevels)
    //             ->map(function ($education) use ($id, $educationRefMap) {
    //                 return [
    //                     'id' => $id,
    //                     'category' => $education['category'] ?? null,
    //                     'refID' => $educationRefMap[$education['category']] ?? null,
    //                     'institute' => $education['institute'] ?? null,
    //                     'location' => $education['location'] ?? null,
    //                     'university' => $education['university'] ?? null,
    //                     'specialization' => $education['specialization'] ?? null,
    //                     'grade' => $education['grade'] ?? null,
    //                     'score' => $education['score'] ?? null,
    //                     'year' => $education['year'] ?? null,
    //                     'visibility' => isset($education['visibility']) ? (int) $education['visibility'] : 1,
    //                     'status' => 1,
    //                 ];
    //             })
    //             ->toArray();
    //         DB::table('cv-education')->insert($educationEntries);

    //         $uniqueSections = array_values(array_unique($sections));
    //         $cvProfileID = DB::table('create-cvprofile')->insertGetId([
    //             'id' => $id,
    //             'profileName' => $profileName,
    //             'sections' => json_encode($uniqueSections),
    //             'status' => 1,
    //         ]);

    //         foreach ($uniqueSections as $section) {
    //             DB::table('create-cvprofilesection')->insertOrIgnore([
    //                 'cvid' => $cvProfileID,
    //                 'id' => $id,
    //                 'section' => $section,
    //                 'status' => 1,
    //             ]);
    //         }

    //         foreach ($sections as $section) {
    //             DB::table('create-cvsection')->insertOrIgnore([
    //                 'id' => $id,
    //                 'section' => $section,
    //                 'status' => 1,
    //             ]);
    //         }

    //         // if ($email) {
    //         //     Http::get(env('EMAIL_API_URL'), [
    //         //         'id' => $id,
    //         //         'authkey' => $authkey,
    //         //         'data' => 'registration',
    //         //         'contents' => urlencode(json_encode([
    //         //             'name' => $fullName,
    //         //             'email' => $email
    //         //         ]))
    //         //     ]);
    //         // }

    //         // External actions
    //         // $this->sendNotification_firstTime($id);
    //         // $this->sendNotificationToAdmin('New App Registration', $fullName, $id);
    //         //$this->userService->sendWelcomeEmail($fullName, $email, $id, $authkey);
    //         // $this->userService->sendWelcomeWhatsApp($fullName, $countryCode, $phone, $id);onse('User creation failed', 500, $e->getMessage());

    //         DB::commit();

    //         return $this->successResponse([['id' => $id, 'authkey' => $userauthKey]], 'User created successfully.');
    //     } catch (\Exception $e) {
    //         DB::rollBack();
    //         return $this->errorResponse('User creation failed', 500, $e->getMessage());
    //     }
    // }
}
