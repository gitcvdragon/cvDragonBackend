<?php

use App\Http\Controllers\{AppConfigController, CvCommonController, OTPAuthController, UserController};
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
Route::get('/social-login', [OTPAuthController::class, 'socialLogin']);


Route::get('/resource-careers', [CvCommonController::class, 'getResourceCarrer']);
Route::post('/experience-fields', [CvCommonController::class, 'getFieldsByExperience']);
Route::get('/resource-carrers/courses', [CvCommonController::class, 'getAllResourceCarrersWithCourses']);
Route::get('/courses/specializations', [CvCommonController::class, 'getAllCoursesWithSpecs']);
Route::get('/resource-carrers/courses/specializations', [CvCommonController::class, 'getAllResourceCarrersWithCoursesandSpecs']);
Route::get('/getSkillsBySpecialization', [CvCommonController::class, 'getSkillsBySpecialization']);

Route::post('/user-name-gender-update', [UserController::class, 'updateNameAndGender'])->middleware('auth:api');
Route::post('/user-uploadProfileImage', [UserController::class, 'uploadProfileImage'])->middleware('auth:api');
Route::post('/user-skill-technical-lang-interest-store', [UserController::class, 'userSkillTechnicalLangInterestStore'])->middleware('auth:api');
Route::post('/get-config', [AppConfigController::class, 'getConfig']);


