<?php

use App\Http\Controllers\{OTPAuthController};
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

//Sending OTP to user Mobile or Email..
Route::post('/send-otp', [OTPAuthController::class, 'sendOtp']); 
Route::post('verify-otp', [OTPAuthController::class, 'verifyOtp']);

Route::get('/auth/google', [OTPAuthController::class, 'redirectToGoogle']);
Route::get('/auth/google/callback', [OTPAuthController::class, 'handleGoogleCallback']);


Route::get('/auth/linkedin', [OTPAuthController::class, 'redirectToLinkedin']);
Route::get('/auth/linkedin/callback', [OTPAuthController::class, 'handleLinkedinCallback']);

  