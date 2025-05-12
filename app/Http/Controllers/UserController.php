<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\User;
use App\Services\UserService;
use App\Traits\ApiResponseTrait;
use Carbon\Carbon;

class UserController extends Controller
{
    use ApiResponseTrait;
    protected UserService $userService;

    public function __construct(UserService $userService)
    {
        $this->userService = $userService;
    }

    public function createUser(Request $request)
    {
        DB::beginTransaction();

        try {
            $data = $request->all();

            $id = now()->timestamp . rand(1, 10000);
            $authkey = md5(microtime() . rand());
            $date = now()->toDateTimeString();
            $profileName = 'First Profile';

         
            //$contents = $this->userService->urlImport($data['contents']);
            $fullName = ucwords(strtolower($contents['fullName'] ?? ''));
            $email = $contents['emailAddress'] ?? null;
            $phone = $data['phoneNumber'] ?? null;
            $countryCode = $data['countryCode'] ?? '';
            $userPhone = $phone ? $countryCode . $phone : null;
            $sectionType = $data['sectionType'] ?? 0;
            $sections = $this->userService->getSectionsByType($sectionType);

            User::create([
                'id' => $id,
                'categoryid' => 1,
                'affiliateID' => $data['affiliateID'] ?? null,
                'appLogin' => Carbon::now(),
                'socialType' => $data['socialType'],
                'socialid' => $data['socialid'],
                'authkey' => $authkey ?? null,
                'username' => $id,
                'playerID' => $data['playerID'],
                'userEmail' => $email,
                'usermobile' => $userPhone,
                'status' => 1,
                'dateUpdated' => Carbon::now(),
            ]);
           
            DB::table('user-basic')->insert([
                'id' => $id,
                'fullName' => $fullName,
                'emailAddress' => $email,
                'countryCode' => $countryCode,
                'phoneNumber' => $phone,
                'profileImageUrl' => '',
                'dateCreated' => $date,
                'status' => 1,
            ]);

            DB::table('cv-contact')->insert([
                'id' => $id,
                'phoneNumber' => $phone,
                'emailAddress' => $email,
                'location' => '',
                'status' => 1,
            ]);

            // DB::table('cv-preference')->insert(['id' => $id, 'status' => 1]);
            // DB::table('cv-basic-info')->insert(['id' => $id, 'cvFullName' => $fullName, 'status' => 1]);
            // DB::table('cv-introduction')->insert(['id' => $id, 'status' => 1]);

            // foreach (['classX' => 1, 'classXII' => 2, 'graduation' => 3, 'diploma' => 4] as $category => $refID) {
            //     DB::table('cv-education')->insert([
            //         'id' => $id,
            //         'category' => $category,
            //         'refID' => $refID,
            //         'status' => 1,
            //     ]);
            // }

            // $uniqueSections = array_values(array_unique($sections));
            // $cvProfileID = DB::table('create-cvprofile')->insertGetId([
            //     'id' => $id,
            //     'profileName' => $profileName,
            //     'sections' => json_encode($uniqueSections),
            //     'status' => 1,
            // ]);

            // foreach ($uniqueSections as $section) {
            //     DB::table('create-cvprofilesection')->insertOrIgnore([
            //         'cvid' => $cvProfileID,
            //         'id' => $id,
            //         'section' => $section,
            //         'status' => 1,
            //     ]);
            // }

            // foreach ($sections as $section) {
            //     DB::table('create-cvsection')->insertOrIgnore([
            //         'id' => $id,
            //         'section' => $section,
            //         'status' => 1,
            //     ]);
            // }

            // External actions
            // $this->sendNotification_firstTime($id);
            // $this->sendNotificationToAdmin('New App Registration', $fullName, $id);
            //$this->userService->sendWelcomeEmail($fullName, $email, $id, $authkey);
            // $this->userService->sendWelcomeWhatsApp($fullName, $countryCode, $phone, $id);

            DB::commit();

            return $this->successResponse([['id' => $id, 'authkey' => $authkey]], 'User created successfully.');
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse('User creation failed', 500, $e->getMessage());
        }
    }
}
