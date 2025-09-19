<?php

use App\Http\Controllers\AppConfigController;
use App\Http\Controllers\CvCommonController;
use App\Http\Controllers\CvDesignController;
use App\Http\Controllers\CvProfileController;
use App\Http\Controllers\CvSectionController;
use App\Http\Controllers\OTPAuthController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\MenuController;
use App\Http\Controllers\Api\Help\ChatController;
use App\Http\Controllers\Api\website\MyfavController;
use App\Http\Controllers\Api\website\AllTemplateswithCategory;
use App\Http\Controllers\Api\website\DigitalCvController;
use App\Http\Controllers\Api\website\MyDocumentsController;
use App\Http\Controllers\Api\website\Subscription\MySubscriptionController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\website\Service\ServiceController;

/*namespace App\Http\Controllers\Api\website\Subscription;

use App\Http\Controllers\Controller;
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
Route::post('/verify-otp', [OTPAuthController::class, 'verifyOtp']);
Route::get('/social-login', [OTPAuthController::class, 'socialLogin']);
Route::get('/logout', [OTPAuthController::class, 'logout'])->middleware('auth:api');

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
Route::post('/user-sections-details', [CvSectionController::class, 'getUserSectionDetails'])->middleware('auth:api');
Route::post('/user-sections-details-add', [CvSectionController::class, 'addData'])->middleware('auth:api');
Route::post('/user-sections-details-update', [CvSectionController::class, 'getUserSectionDetailsUpdate'])->middleware('auth:api');
Route::post('/user-sections-details-softDelete', [CvSectionController::class, 'getUserSectionDetailsSoftDelete'])->middleware('auth:api');
Route::post('/user-sections-details-hardDelete', [CvSectionController::class, 'getUserSectionDetailsHardDelete'])->middleware('auth:api');
Route::post('/user-sections-rename', [CvSectionController::class, 'updateShowName'])->middleware('auth:api');


// Route::post('/get-config', [AppConfigController::class, 'getConfig']);
Route::post('/get-config', [AppConfigController::class, 'getActiveConfigs']);
//sections apis
Route::get('/cv-sections', [CvSectionController::class, 'getGroupSections']);
Route::post('/resource-section-questions', [CvSectionController::class, 'getSectionQuestions']);

//Designs Api
Route::get('/cv-setting', [CvDesignController::class, 'allCvDesgin']);
// Route::get('/profile-fonts', [CvDesignController::class, 'allProfileFonts']);
// Route::get('/profile-colors', [CvDesignController::class, 'allProfileColors']);

//Profile Design        000
Route::post('/user-profile', [CvProfileController::class, 'getUserProfile'])->middleware('auth:api');
Route::post('/user-profile-add', [CvProfileController::class, 'addUserProfile'])->middleware('auth:api');
Route::post('/user-profile-update', [CvProfileController::class, 'updateUserProfile'])->middleware('auth:api');
Route::post('/user-add-profile-section-data', [CvProfileController::class, 'addData'])->middleware('auth:api');

Route::post('/user-section-order-update', [CvProfileController::class, 'updateUserProfileSectionOrderUpdate'])->middleware('auth:api');

Route::post('/user-profile-delete', [CvProfileController::class, 'deleteUserProfile'])->middleware('auth:api');
//Route::any('{any}', [FallbackController::class, 'handle'])->where('any', '.*');


Route::post('/help-chat/add', [ChatController::class, 'addChat'])->middleware('auth:api');

Route::post('/help-chat/user', [ChatController::class, 'userChatIndividual'])->middleware('auth:api');
Route::get('/my-favorites', [MyfavController::class, 'getFavorites'])->middleware('auth:api');

Route::post('/digital-cv-create', [DigitalCvController::class, 'createDigitalCv'])->middleware('auth:api');
Route::get('/digital-cv/{userId}', [DigitalCvController::class, 'DigitalCv']);
Route::get('/digital-cv-show', [DigitalCvController::class, 'showDigitalCv'])->middleware('auth:api');
Route::post('/digital-cv-show-from-profile', [DigitalCvController::class, 'showallDigitalCv'])->middleware('auth:api');

Route::post('/my-documents/upload', [MyDocumentsController::class, 'uploadDocument'])->middleware('auth:api');
Route::post('/my-documents/edit', [MyDocumentsController::class, 'editDocument'])->middleware('auth:api');

Route::get('/my-documents', [MyDocumentsController::class, 'getMyDocuments'])->middleware('auth:api');
Route::get('/all-templates', [AllTemplateswithCategory::class, 'getAllTemplatesWithCategory'])->middleware('auth:api');

Route::delete('/my-documents/{documentID}', [MyDocumentsController::class, 'deleteDocument'])->middleware('auth:api');
Route::get('/subscriptions/active', [MySubscriptionController::class, 'getActiveSubscriptions'])->middleware('auth:api');
Route::post('/redeem-voucher', [MySubscriptionController::class, 'redeemVoucher'])->middleware('auth:api');




Route::middleware('auth:api')->get('/services/active', [ServiceController::class, 'activeServices']);
Route::middleware('auth:api')->get('/services/completed', [ServiceController::class, 'completedServices']);
Route::middleware('auth:api')->get('/services/details', [ServiceController::class, 'activeServices']);
