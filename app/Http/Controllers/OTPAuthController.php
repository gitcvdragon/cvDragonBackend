<?php
namespace App\Http\Controllers;

use App\Models\CreateCvuserprofile;

use App\Models\CvContact;

use App\Models\User;

use App\Models\UserBasic;
use App\Traits\ApiResponseTrait;
use App\Traits\OtpTrait;use Carbon\Carbon;use Illuminate\Http\Request;use Illuminate\Support\Facades\DB;use Illuminate\Support\Facades\Validator;use Tymon\JWTAuth\Facades\JWTAuth;

class OTPAuthController extends Controller
{
    use OtpTrait, ApiResponseTrait;

    public function sendOtp(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'identifier' => 'required|string',
        ]);

        $validator->after(function ($validator) use ($request) {
            $identifier = $request->input('identifier');

            $isEmail = filter_var($identifier, FILTER_VALIDATE_EMAIL);
            $isPhone = preg_match('/^(\+91|91)?[6-9]\d{9}$/', $identifier);

            if (! $isEmail && ! $isPhone) {
                $validator->errors()->add('identifier', 'Please use valid email or phone number.');
            }
        });

        if ($validator->fails()) {
            return $this->validationErrorResponse($validator->errors()->first(), 'Validation failed');
        }

        $otp = $this->generateAndStoreOtp($request->identifier);
        return $this->successResponse(['otp' => $otp], 'Your One time OTP sent successfully!!  Please use it within 5 minutes.');
    }

    public function verifyOtp(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'identifier' => [
                'required',
                'string',
                function ($attribute, $value, $fail) {
                    if (! filter_var($value, FILTER_VALIDATE_EMAIL) && ! preg_match('/^[0-9]{10}$/', $value)) {
                        $fail('The identifier must be a valid email address or mobile number.');
                    }
                },
            ],
            'otp'        => 'required|digits:6',
        ]);

        if ($validator->fails()) {
            return $this->validationErrorResponse($validator->errors()->first(), 'Validation failed');
        }

        $request->validate([
            'identifier' => 'required|string',
            'otp'        => 'required',
        ]);

        $record = DB::table('user_otps')->where('identifier', $request->identifier)->where('otp', $request->otp)->first();

        if (! $record) {
            return $this->errorResponse('OTP is not valid!', 401);
        }

        $user         = User::where('userEmail', $request->identifier)->orWhere('usermobile', $request->identifier)->first();
        $userauthKey  = md5(microtime() . rand());
        $userCategory = 1;

        if ($user) {
            $token  = JWTAuth::fromUser($user);
            $record = DB::table('user_otps')
                ->where('identifier', $request->identifier)
                ->where('otp', $request->otp)
                ->first();

            if (! $record) {
                return $this->errorResponse('OTP is not valid!', 401);
            }

            DB::table('user_otps')
                ->where('identifier', $request->identifier)
                ->where('otp', $request->otp)
                ->delete();

            $user       = User::with('userBasic')->find($user->id);
            $showWizard = $user->userBasic ? $user->userBasic->showWizard : null;
            return $this->successResponse(
                [
                    'token'        => $token,
                    'userId'       => $user->id,
                    'userauthKey'  => $userauthKey,
                    'userCategory' => $userCategory,
                    'showWizard'   => $showWizard,
                ],
                'OTP verified successfully!!',
            );
        } else {
            // New user registration
            try {
                DB::beginTransaction();
                $id          = now()->timestamp . rand(1, 1000);
                $userauthKey = md5(microtime() . rand());
                $user        = User::create([
                    'id'         => $id,
                    'userEmail'  => filter_var($request->identifier, FILTER_VALIDATE_EMAIL) ? $request->identifier : null,
                    'usermobile' => is_numeric($request->identifier) ? $request->identifier : null,
                    'categoryid' => $userCategory,
                    'authKey'    => $userauthKey,
                ]);

                $createdId = $user->id;

                $user->update([
                    'username' => $createdId,
                ]);

                UserBasic::create([
                    'id'           => $user->id,
                    'showWizard'   => 1,
                    'emailAddress' => filter_var($request->identifier, FILTER_VALIDATE_EMAIL) ? $request->identifier : null,
                    'phoneNumber'  => is_numeric($request->identifier) ? $request->identifier : null,
                ]);

                CreateCvuserprofile::create([
                    'id'          => $user->id,
                    'profileName' => 'First Profile',
                ]);

                CvContact::create([
                    'id'           => $user->id,
                    'phoneNumber'  => is_numeric($request->identifier) ? $request->identifier : null,
                    'emailAddress' => filter_var($request->identifier, FILTER_VALIDATE_EMAIL) ? $request->identifier : null,
                ]);

                DB::commit();
                $token = JWTAuth::fromUser($user);

                $user = \App\Models\User::find( $createdId);

                if ($user) {
                    $token = JWTAuth::fromUser($user);
                    JWTAuth::invalidate($token, true);
                }
               // $userId
                return $this->successResponse(
                    [
                        'user_id'      => $user->id,
                        'ftl'      => $user->ftl,
                        'token'        => $token,
                        'userCategory' => $userCategory,
                    ],
                    'OTP verified successfully and New User is created !!',
                );
            } catch (\Exception $e) {
                DB::rollBack();
                return response()->json(
                    [
                        'success' => false,
                        'message' => 'Failed to create user.',
                        'error'   => $e->getMessage(),
                    ],
                    500,
                );
            }
        }
    }

    public function socialLogin(Request $request)
    {
        $validator = Validator::make(
            $request->all(),
            [
                'social_id'    => 'required|string|max:255',
                'social_token' => 'required|string|max:255',
                'social_type'  => 'required|in:0,1,2',
            ],
            [
                'social_id.required'    => 'Social ID is required.',
                'social_id.string'      => 'Social ID must be a string.',
                'social_token.required' => 'Social token is required.',
                'social_token.string'   => 'Social token must be a string.',
                'social_type.required'  => 'Social type is required.',
                'social_type.in'        => 'Social type must be one of: 0, 1, 2.',
            ],
        );

        if ($validator->fails()) {
            return $this->validationErrorResponse($validator->errors()->first(), 'Validation failed');
        }

        $social_id    = $request->social_id;
        $social_token = $request->social_token;
        $social_type  = $request->social_type;
        $userCategory = 1;
        $userauthKey  = md5(microtime() . rand());

        $user = User::where('socialid', $social_id)->where('socialToken', $social_token)->first();

        if ($user) {
            $token      = JWTAuth::fromUser($user);
            $user       = User::with('userBasic')->find($user->id);
            $showWizard = $user->userBasic ? $user->userBasic->showWizard : null;

            return $this->successResponse(
                [
                    'token'        => $token,
                    'userId'       => $user->id,
                    'userauthKey'  => $userauthKey,
                    'userCategory' => $userCategory,
                    'showWizard'   => $showWizard,
                ],
                'Social login successful!!',
            );
        } else {
            DB::beginTransaction();

            $id   = now()->timestamp . rand(1, 1000);
            $user = User::create([
                'id'          => $id,
                'socialid'    => $social_id,
                'socialToken' => $social_token,
                'categoryid'  => $userCategory,
                'socialType'  => $social_type,
            ]);

            $user       = User::with('userBasic')->find($user->id);
            $showWizard = $user->userBasic ? $user->userBasic->showWizard : null;

            UserBasic::create([
                'id'           => $user->id,
                'showWizard'   => 1,
                'emailAddress' => null,
                'phoneNumber'  => null,
            ]);

            CreateCvuserprofile::create([
                'id'          => $user->id,
                'profileName' => 'First Profile',
            ]);

            DB::commit();

            $token = JWTAuth::fromUser($user);

            return $this->successResponse(
                [
                    'user_id'      => $user->id,
                    'token'        => $token,
                    'userCategory' => $userCategory,
                    'showWizard'   => $showWizard,
                ],
                'Social login successfull and New user created!!',
            );
        }
    }

    public function logout(Request $request)
    {
        try {
            JWTAuth::invalidate(JWTAuth::getToken());
            return $this->successResponse([], 'User logged out successfully!');
        } catch (JWTException $e) {
            return $this->errorResponse('Failed to logout, token invalid or expired.', 401);
        }
    }
}
