<?php

namespace App\Traits;

use Illuminate\Support\Facades\Crypt;

trait CryptHelper
{
    /**
     * Safely decrypt a value
     */
    public function decryptSafe($value)
    {
        try {
            $decrypted = Crypt::decryptString($value);
            return substr(preg_replace('/\D/', '', $decrypted), 0, 5);
        } catch (\Exception $e) {
            return null; // Or throw an error if you prefer
        }
    }


    /**
     * Safely encrypt a value
     */
    public function encryptSafe($value)
    {
        try {
            // Only keep digits and limit to 5
            $cleanValue = substr(preg_replace('/\D/', '', $value), 0, 5);

            // Only encrypt if there's something left
            if ($cleanValue !== '') {
                return Crypt::encryptString($cleanValue);
            }

            return null; // or throw exception if empty
        } catch (\Exception $e) {
            return $value; // return as-is if encryption fails
        }
    }

}
