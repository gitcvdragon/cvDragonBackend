<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Traits\ApiResponseTrait;
use App\Traits\OtpTrait;
use Illuminate\Support\Facades\DB;
use Tymon\JWTAuth\Facades\JWTAuth;
use App\Models\{CreateCvprofile, CreateCvuserprofile, CvBasicInfo, CvContact, User, UserBasic};

class OTPAuthController extends Controller
{
    use OtpTrait, ApiResponseTrait;

    // Method to Send OTP to User for Email or Phone Number Validation

    //Send OTP to the provided identifier (email or phone number).This method validates the input identifier to ensure it is either a valid email or a valid phone number (Indian format).If the input is invalid, it adds a custom validation error message. Once validated, it generates a one-time password (OTP) and stores it for later verification. The OTP is returned to the user with a success message, indicating that the OTP must be used within 5 minutes.

    public function sendOtp(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'identifier' => 'required|string',
        ]);

        $validator->after(function ($validator) use ($request) {
            $identifier = $request->input('identifier');

            $isEmail = filter_var($identifier, FILTER_VALIDATE_EMAIL);
            $isPhone = preg_match('/^(\+91|91)?[6-9]\d{9}$/', $identifier);

            if (!$isEmail && !$isPhone) {
                $validator->errors()->add('identifier', 'Please use valid email or phone number.');
            }
        });

        if ($validator->fails()) {
            return $this->validationErrorResponse($validator->errors()->first(), 'Validation failed');
        }

        $otp = $this->generateAndStoreOtp($request->identifier);
        return $this->successResponse(['otp' => $otp], 'Your One time OTP sent successfully!!  Please use it within 5 minutes.');
    }

    // Method to Verify OTP and Authenticate User

    // Verify the provided OTP and authenticate the user.This method first validates the incoming OTP and identifier (email/phone number). It checks the database to find a matching OTP record that has not expired. If the OTP is invalid or expired, an error response is returned. Upon successful verification, the user is authenticated (or created if they don't exist) and a JWT token is generated for further interactions. The response includes the token and user data.

    public function verifyOtp(Request $request)
    {
        // Step 1: Manual Validation
        $validator = Validator::make($request->all(), [
            'identifier' => [
                'required',
                'string',
                function ($attribute, $value, $fail) {
                    if (!filter_var($value, FILTER_VALIDATE_EMAIL) && !preg_match('/^[0-9]{10}$/', $value)) {
                        $fail('The identifier must be a valid email address or mobile number.');
                    }
                },
            ],
            'otp' => 'required|digits:6',
        ]);

        if ($validator->fails()) {
            return $this->validationErrorResponse($validator->errors()->first(), 'Validation failed');
        }

        // Step 1: Validate the OTP input
        $request->validate([
            'identifier' => 'required|string',
            'otp' => 'required',
        ]);

        // Step 2: Find the OTP record in the database
        $record = DB::table('user_otps')->where('identifier', $request->identifier)->where('otp', $request->otp)->where('expires_at', '>', now())->first();

        // Step 3: Handle invalid or expired OTP
        if (!$record) {
            return $this->errorResponse('OTP is not valid!', 401);
        }

        //Check if user already exists
        $user = User::where('userEmail', $request->identifier)->orWhere('usermobile', $request->identifier)->first();
        $userauthKey = md5(microtime() . rand());
        $userCategory = 1; // default category

        if ($user) {
            $token = JWTAuth::fromUser($user);
            $user = User::with('userBasic')->find($user->id);
            $showWizard = $user->userBasic ? $user->userBasic->showWizard : null;
            return $this->successResponse(
                [
                    'token' => $token,
                    'userId' => $user->id,
                    'userauthKey' => $userauthKey,
                    'userCategory' => $userCategory,
                    'showWizard' => $showWizard,
                ],
                'OTP verified successfully!!',
            );
        } else {
            // New user registration
            try {
                DB::beginTransaction();
                $id = now()->timestamp . rand(1, 1000);
                $userauthKey = md5(microtime() . rand());
                $user = User::create([
                    'id' => $id,
                    'userEmail' => filter_var($request->identifier, FILTER_VALIDATE_EMAIL) ? $request->identifier : null,
                    'usermobile' => is_numeric($request->identifier) ? $request->identifier : null,
                    'categoryid' => $userCategory,
                    'authKey' => $userauthKey,
                ]);

                UserBasic::create([
                    'id' => $user->id,
                    'showWizard' => 1,
                    'emailAddress' => filter_var($request->identifier, FILTER_VALIDATE_EMAIL) ? $request->identifier : null,
                    'phoneNumber' => is_numeric($request->identifier) ? $request->identifier : null,
                ]);

                CreateCvuserprofile::create([
                    'id' => $user->id,
                    'profileName' => 'First Profile',
                ]);

                CvContact::create([
                    'id' => $user->id,
                    'phoneNumber' => is_numeric($request->identifier) ? $request->identifier : null,
                    'emailAddress' => filter_var($request->identifier, FILTER_VALIDATE_EMAIL) ? $request->identifier : null,
                ]);

                DB::commit();
                $token = JWTAuth::fromUser($user);

                return $this->successResponse(
                    [
                        'user_id' => $user->id,
                        'token' => $token,
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
                        'error' => $e->getMessage(),
                    ],
                    500,
                );
            }
        }
    }

    //If social_id and social_token are provided: The system checks for a matching entry in the users table. Upon successful match, user is authenticated.

    public function socialLogin(Request $request)
    {
        // Validate request inputs with custom messages
        $validator = Validator::make(
            $request->all(),
            [
                'social_id' => 'required|string|max:255',
                'social_token' => 'required|string|max:255',
                'social_type' => 'required|in:0,1,2',
            ],
            [
                'social_id.required' => 'Social ID is required.',
                'social_id.string' => 'Social ID must be a string.',
                'social_token.required' => 'Social token is required.',
                'social_token.string' => 'Social token must be a string.',
                'social_type.required' => 'Social type is required.',
                'social_type.in' => 'Social type must be one of: 0, 1, 2.',
            ],
        );

        if ($validator->fails()) {
            return $this->validationErrorResponse($validator->errors()->first(), 'Validation failed');
        }

        $social_id = $request->social_id;
        $social_token = $request->social_token;
        $social_type = $request->social_type;
        $userCategory = 1; // default category
        $userauthKey = md5(microtime() . rand());

        // Search for existing user by social_id and social_token
        $user = User::where('socialid', $social_id)->where('socialToken', $social_token)->first();

        if ($user) {
            // User exists, generate token and fetch showWizard flag
            $token = JWTAuth::fromUser($user);
            $user = User::with('userBasic')->find($user->id);
            $showWizard = $user->userBasic ? $user->userBasic->showWizard : null;

            return $this->successResponse(
                [
                    'token' => $token,
                    'userId' => $user->id,
                    'userauthKey' => $userauthKey,
                    'userCategory' => $userCategory,
                    'showWizard' => $showWizard,
                ],
                'Social login successful!!',
            );
        } else {
            DB::beginTransaction();

            // New user registration
            $id = now()->timestamp . rand(1, 1000);
            $user = User::create([
                'id' => $id,
                'socialid' => $social_id,
                'socialToken' => $social_token,
                'categoryid' => $userCategory,
                'socialType' => $social_type,
            ]);

            $user = User::with('userBasic')->find($user->id);
            $showWizard = $user->userBasic ? $user->userBasic->showWizard : null;

            UserBasic::create([
                'id' => $user->id,
                'showWizard' => 1,
                'emailAddress' => null, // no email from social login here
                'phoneNumber' => null, // no phone from social login here
            ]);

            CreateCvuserprofile::create([
                'id' => $user->id,
                'profileName' => 'First Profile',
            ]);

            // Commit the transaction
            DB::commit();

            $token = JWTAuth::fromUser($user);

            return $this->successResponse(
                [
                    'user_id' => $user->id,
                    'token' => $token,
                    'userCategory' => $userCategory,
                    'showWizard' => $showWizard,
                ],
                'Social login successfull and New user created!!',
            );
        }
    }
}
