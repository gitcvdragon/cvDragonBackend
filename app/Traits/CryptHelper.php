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
            return Crypt::decryptString($value);
        } catch (\Exception $e) {
            return $value; // return as-is if it's not encrypted
        }
    }

    /**
     * Safely encrypt a value
     */
    public function encryptSafe($value)
    {
        try {
            return Crypt::encryptString($value);
        } catch (\Exception $e) {
            return $value; // return as-is if encryption fails
        }
    }
}
