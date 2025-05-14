<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\{CVSkill, User};
use App\Services\UserService;
use App\Traits\ApiResponseTrait;
use Carbon\Carbon;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Validator;

class UserController extends Controller
{
    use ApiResponseTrait;
    protected UserService $userService;

    public function __construct(UserService $userService)
    {
        $this->userService = $userService;
    }

    // public function saveUserProfile(Request $request)
    // {
    //     // Step 1: Validate user profile data
    //     $request->validate([
    //         'full_name' => 'required|string|max:255',
    //         'gender' => 'required|in:male,female,other',
    //         'category' => 'required|string|in:student,fresher,experience',
    //         'course' => 'nullable|string|max:255',
    //         'specialization' => 'nullable|string|max:255',
    //         'skills' => 'array', // Validate as an array
    //         'technical_skills' => 'array', // Validate as an array
    //         'interests' => 'array', // Validate as an array
    //         'languages' => 'array', // Validate as an array
    //         'images' => 'array', // Validate as an array
    //     ]);

    //     // Step 2: Retrieve the authenticated user
    //     // $user = auth()->user();


    //     // Step 3: Update the user's profile data
    //     $user->full_name = $request->full_name;
    //     $user->gender = $request->gender;
    //     $user->category = $request->category;
    //     $user->course = $request->course;
    //     $user->specialization = $request->specialization;
    //     $user->save();


    //     DB::table('user-basic')->insert([
    //         'id' => $id,
    //         'fullName' => $fullName ?? null,
    //         'emailAddress' => $email ?? null,
    //         'countryCode' => $countryCode ?? null,
    //         'phoneNumber' => $phone ?? null,
    //         'profileImageUrl' => '',
    //         'dateCreated' => $date,
    //         'status' => 1,
    //     ]);

    //     // Step 4: Sync the additional sections like skills, technical skills, etc.
    //     $this->syncSection(CVSkill::class, 'skills', $user->id, $request->skills);
    //     // $this->syncSection(CVTechnical::class, 'technical_skills', $user->id, $request->technical_skills);
    //     // $this->syncSection(CVInterest::class, 'interests', $user->id, $request->interests);
    //     // $this->syncSection(CVLanguage::class, 'languages', $user->id, $request->languages);
    //     // $this->syncSection(CVImage::class, 'images', $user->id, $request->images);

    //     // Step 5: Return success response
    //     return $this->successResponse(['user' => $user], 'User profile saved successfully.');
    // }

    // private function syncSection($modelClass, $key, $userId, $data)
    // {
    //     if (!is_array($data)) {
    //         return;
    //     }

    //     // Step 1: Delete old records
    //     $modelClass::where('user_id', $userId)->delete();

    //     // Step 2: Insert new records for the given data
    //     foreach ($data as $item) {
    //         $modelClass::create([
    //             'user_id' => $userId,
    //             'value' => $item, // You can adjust this to match the correct column names of the related table
    //         ]);
    //     }
    // }

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

    // public function verifyUserSocial(Request $request)
    // {
    //     $validator = Validator::make($request->all(), [
    //         'socialid' => 'required|string',
    //     ]);

    //     if ($validator->fails()) {
    //         return $this->validationErrorResponse($validator->errors()->first(), 'Validation failed!!');
    //     }

    //     $socialID = $request->input('socialid');

    //     $user = User::where('socialid', $socialID)->where('status', 1)->first();

    //     if (!$user) {
    //         return $this->errorResponse('User not found or inactive', 404);
    //     }

    //     return $this->successResponse(
    //         [
    //             'id' => $user->id,
    //             'authKey' => $user->authKey,
    //             'categoryid' => $user->categoryid,
    //             'dateUpdated' => $user->dateUpdated,
    //             'playerID' => $user->playerID,
    //         ],
    //         'User found',
    //     );
    // }
}
