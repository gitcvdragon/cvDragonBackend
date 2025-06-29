<?php

use App\Http\Controllers\AppConfigController;
use App\Http\Controllers\CvCommonController;
use App\Http\Controllers\CvDesignController;
use App\Http\Controllers\CvProfileController;
use App\Http\Controllers\CvSectionController;
use App\Http\Controllers\FallbackController;
use App\Http\Controllers\OTPAuthController;
use App\Http\Controllers\UserController;
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
// fallback route for ANY unknown API endpoint

//Sending OTP to user Mobile or Email..
Route::post('/send-otp', [OTPAuthController::class, 'sendOtp']);
Route::post('verify-otp', [OTPAuthController::class, 'verifyOtp']);
Route::get('/social-login', [OTPAuthController::class, 'socialLogin']);

// resouce-career options
Route::get('/resource-careers', [CvCommonController::class, 'getResourceCarrer']);
Route::post('/experience-fields', [CvCommonController::class, 'getFieldsByExperience']);
Route::get('/resource-carrers/courses', [CvCommonController::class, 'getAllResourceCarrersWithCourses']);
Route::get('/courses/specializations', [CvCommonController::class, 'getAllCoursesWithSpecs']);
Route::get('/resource-carrers/courses/specializations', [CvCommonController::class, 'getAllResourceCarrersWithCoursesandSpecs']);
Route::get('/getSkillsBySpecialization', [CvCommonController::class, 'getSkillsBySpecialization']);

// users details
Route::post('/user-name-gender-update', [UserController::class, 'updateNameAndGender'])->middleware('auth:api');
Route::post('/user-uploadProfileImage', [UserController::class, 'uploadProfileImage'])->middleware('auth:api');
Route::post('/user-skill-technical-lang-interest-store', [UserController::class, 'userSkillTechnicalLangInterestStore'])->middleware('auth:api');
Route::post('/user-sections-details', [CvSectionController::class, 'getUserSectionDetails']);
Route::post('/user-sections-details-add', [CvSectionController::class, 'getUserSectionDetailsAdd']);
Route::post('/user-sections-details-update', [CvSectionController::class, 'getUserSectionDetailsUpdate']);
Route::post('/user-sections-details-softDelete', [CvSectionController::class, 'getUserSectionDetailsSoftDelete']);
Route::post('/user-sections-details-hardDelete', [CvSectionController::class, 'getUserSectionDetailsHardDelete']);
Route::post('/get-config', [AppConfigController::class, 'getConfig']);

//sections apis
Route::get('/cv-sections', [CvSectionController::class, 'getGroupSections']);
Route::post('/resource-section-questions', [CvSectionController::class, 'getSectionQuestions']);

//Designs Api
Route::get('/cv-setting', [CvDesignController::class, 'allCvDesgin']);
// Route::get('/profile-fonts', [CvDesignController::class, 'allProfileFonts']);
// Route::get('/profile-colors', [CvDesignController::class, 'allProfileColors']);

//Profile Design        000
Route::post('/user-profile', [CvProfileController::class, 'getUserProfile']);
Route::post('/user-profile-add', [CvProfileController::class, 'addUserProfile'])->middleware('auth:api');
Route::post('/user-profile-update', [CvProfileController::class, 'updateUserProfile'])->middleware('auth:api');
Route::post('/user-add-profile-section-data', [CvProfileController::class, 'addData'])->middleware('auth:api');

Route::post('/user-section-order-update', [CvProfileController::class, 'updateUserProfileSectionOrderUpdate'])->middleware('auth:api');

Route::post('/user-profile-delete', [CvProfileController::class, 'deleteUserProfile'])->middleware('auth:api');
Route::any('{any}', [FallbackController::class, 'handle'])->where('any', '.*');
