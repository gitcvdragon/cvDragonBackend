<?php
namespace App\Http\Controllers\Api\Website;


use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Illuminate\Support\Facades\Validator;
use App\Traits\ApiResponseTrait;
use App\Traits\OtpTrait;
use Tymon\JWTAuth\Facades\JWTAuth;
use App\Models\{CreateCvprofile, CreateCvuserprofile, CvBasicInfo, CvContact, User, UserBasic};
use Tymon\JWTAuth\Exceptions\JWTException;
class ProfileController extends Controller
{

    use ApiResponseTrait;

    public function deleteAccount(Request $request)
    {
        $userId = $request->input('user_id');

        DB::table('users_basic')
            ->where('id', $userId)
            ->update(['status' => 0]);
        DB::table('users')
            ->where('id', $userId)
            ->update(['status' => 0]);

        DB::table('create-cvprofiles')
            ->where('id', $userId)
            ->update(['status' => 0]);

        return $this->successResponse(
            [
                'user_id' => $userId,
                'status'  => 0,
            ],
            'Status updated to 0 successfully.'
        );
    }

    public function updateWizardEducationProfile(Request $request)
    {
        $request->validate([
            'wizardEducationProfileID' => 'required|integer',
        ]);

                                                  // Get authenticated user id from JWT
        $userId                   = auth()->id(); // or JWTAuth::user()->id
        $wizardEducationProfileID = $request->input('wizardEducationProfileID');

        // Update users_basic table
        DB::table('users_basic')
            ->where('id', $userId)
            ->update(['wizardEducationProfileID' => $wizardEducationProfileID]);

        return $this->successResponse(
            [
                // 'user_id' => $userId,
                // 'wizardEducationProfileID' => $wizardEducationProfileID,
            ],
            'wizardEducationProfileID updated successfully.'
        );
    }

    public function updateNotificationSettings(Request $request)
{
    $request->validate([
        'notiHelp' => 'required|boolean',
        'notiDesign' => 'required|boolean',
        'notiPlacement' => 'required|boolean',
        'notiOthersendMailNoti' => 'required|boolean',
        'sendWhatsAppNoti' => 'required|boolean',
        'sendSMSNoti' => 'required|boolean',
    ]);

    $userId = auth()->id(); // get logged-in user

    $updateData = $request->only([
        'notiHelp',
        'notiDesign',
        'notiPlacement',
        'notiOthersendMailNoti',
        'sendWhatsAppNoti',
        'sendSMSNoti',
    ]);

    DB::table('users_basic')
        ->where('id', $userId)
        ->update($updateData);

    return $this->successResponse(
        [
            'user_id' => $userId,
            'notification_settings' => $updateData,
        ],
        'Notification settings updated successfully.'
    );
}


}
