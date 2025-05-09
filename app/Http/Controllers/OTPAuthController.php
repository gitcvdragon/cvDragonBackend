<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Traits\ApiResponseTrait;
use App\Traits\OtpTrait;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Tymon\JWTAuth\Facades\JWTAuth;
use Laravel\Socialite\Facades\Socialite;
use Illuminate\Support\Str;

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
        // Step 1: Validate the OTP input
        $request->validate([
            'identifier' => 'required|string',
            'otp' => 'required',
        ]);

        // Step 2: Find the OTP record in the database
        $record = DB::table('user_otps')
            ->where('identifier', $request->identifier)
            ->where('otp', $request->otp)
            ->where('expires_at', '>', now()) // Check if OTP is not expired
            ->first();

        // Step 3: Handle invalid or expired OTP
        if (!$record) {
            return $this->errorResponse('OTP is not valid!', 401);
        }

        // Step 4: OTP is valid, now authenticate the user (or create a new user)
        $user = User::findOrCreateUser($request->identifier);

        // Step 5: Generate a JWT token for the user
        $token = JWTAuth::fromUser($user);

        // Step 6: Return success response with token and user data
        return $this->successResponse(
            [
                'token' => $token,
                'user' => $user,
            ],
            'OTP verified successfully',
        );
    }

    // Method to Generate Google OAuth Redirect URL.Generates and returns the Google OAuth login URL via Socialite.

    public function redirectToGoogle()
    {
        $redirectUrl = Socialite::driver('google')->stateless()->redirect()->getTargetUrl();
        return $this->successResponse(['url' => $redirectUrl], 'Google redirect URL generated successfully!!!');
        // return Socialite::driver('google')->redirect();
    }

    // Handle Google OAuth Callback and User Authentication

    // This method retrieves the user's information from Google using the Socialite package, creates a new user record
    // if one doesn't exist (based on the email), and stores relevant data (Google ID, token, etc.) in the database.If the user is successfully created or authenticated, a JWT token is generated for API access.In case of any error during the process, a relevant error message is returned.

    public function handleGoogleCallback()
    {
        try {
            // Retrieve the user information from Google
            $googleUser = Socialite::driver('google')->stateless()->user();

            // Attempt to find the user by their social ID
            $existingUser = User::where('socialid', $googleUser->getId())->first();

            if ($existingUser) {
                // If the user already exists, log them in
                Auth::login($existingUser);
                $user = $existingUser; // Use the existing user
            } else {
                // Create a new user if one doesn't exist
                $user = User::firstOrCreate(
                    ['userEmail' => $googleUser->getEmail()],
                    [
                        'username' => $googleUser->getName(),
                        'socialType' => 0, //0 = google
                        'socialid' => $googleUser->getId(),
                        'socialToken' => $googleUser->token,
                        'authKey' => Str::random(32),
                        'status' => 1,
                        'dateUpdated' => now(),
                    ],
                );
                Auth::login($user);
            }
            // Generate a JWT token for API authentication
            $token = JWTAuth::fromUser($user);

            // Return success response
            return $this->successResponse(
                [
                    'token' => $token,
                    'user' => $user,
                ],
                'User authenticated successfully via Google.',
            );
        } catch (\Exception $e) {
            // Return error with debug details if app is in debug mode
            return $this->errorResponse('Something went wrong during Google login. Please try again later.', 500, config('app.debug') ? ['exception' => $e->getMessage()] : null);
        }
    }

    public function redirectToLinkedin()
    {
        //$redirectUrl = Socialite::driver('linkedin')->stateless()->redirect()->getTargetUrl();
        //return $this->successResponse(['url' => $redirectUrl], 'Linkdin redirect URL generated successfully!!!');
        return Socialite::driver('linkedin')->stateless()->redirect();
    }

    public function handleLinkedinCallback()
    {

        $linkedInUser = Socialite::driver('linkedin')->stateless()->user();

        dd( $linkedInUser);
        try {
            // Retrieve the user information from LinkedIn
            

            // Attempt to find the user by their social ID
            $existingUser = User::where('socialid', $linkedInUser->getId())->first();

            if ($existingUser) {
                // If the user already exists, log them in
                Auth::login($existingUser);
                $user = $existingUser;
            } else {
                // Create a new user if one doesn't exist
                $user = User::firstOrCreate(
                    ['userEmail' => $linkedInUser->getEmail()],
                    [
                        'username' => $linkedInUser->getName(),
                        'socialType' => 1, // 1 = LinkedIn
                        'socialid' => $linkedInUser->getId(),
                        'socialToken' => $linkedInUser->token,
                        'authKey' => Str::random(32),
                        'status' => 1,
                        'dateUpdated' => now(),
                    ],
                );
                Auth::login($user);
            }
            // Generate a JWT token for API authentication
            $token = JWTAuth::fromUser($user);

            // Return success response
            return $this->successResponse(
                [
                    'token' => $token,
                    'user' => $user,
                ],
                'User authenticated successfully via Google.',
            );
        } catch (\Exception $e) {
            // Return error with debug details if app is in debug mode
            return $this->errorResponse('Something went wrong during Google login. Please try again later.', 500, config('app.debug') ? ['exception' => $e->getMessage()] : null);
        }
    }
}
