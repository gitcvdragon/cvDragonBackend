<?php
namespace App\Traits;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

trait OtpTrait
{
    protected function generateAndStoreOtp($identifier)
    {

        // $otp = str_pad(rand(0, 999999), 6, '0', STR_PAD_LEFT);
        $otp = 123456;
        // Step 2: Handle phone number formatting (if it's an Indian phone number)
        if (preg_match('/^(\+91|91)?[6-9]\d{9}$/', $identifier)) {
            $identifier = preg_replace('/^(\+91|91)/', '', $identifier); // strip country code
        }

        DB::table('user_otps')->updateOrInsert(
            ['identifier' => $identifier],
            [
                'otp'        => $otp,
                'expires_at' => now()->addMinutes(5),
                'created_at' => now(),
                'updated_at' => now(),
            ],
        );

        // Step 4: Simulate OTP sending for local and testing environments
        if (app()->environment('local') || app()->environment('testing')) {
            Log::info("Simulated OTP sent to {$identifier}: {$otp}");
        }

        return $otp; // Step 5: Return OTP
    }
}
