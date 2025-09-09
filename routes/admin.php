<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\Admin\User\AllUserFetchController;
use App\Http\Controllers\Api\Admin\Templates\TemplatesFetchController;
use App\Http\Controllers\Api\Admin\ResumeColors\AllColorController;
use App\Http\Controllers\Api\Admin\Fontss\AllFontController;
use App\Http\Controllers\Api\Admin\Documents\UserAllDocumentController;
use App\Http\Controllers\Api\Admin\DigitalCv\DigitalCvController;
use App\Http\Controllers\Api\Admin\Testmonial\TestMonialController;
use App\Http\Controllers\Api\Admin\FeedBack\FeedBackController;
use App\Http\Controllers\Api\Admin\HelpCenter\HelpCenterController;
use App\Http\Controllers\Api\Admin\Section\SectionController;


Route::prefix('admin')->group(function () {


    Route::get('/sections', [SectionController::class, 'listSections']);
Route::get('/sections/{id}', [SectionController::class, 'viewSection']);
Route::delete('/sections/{id}', [SectionController::class, 'deleteSection']);


    Route::prefix('help-center')->group(function () {
        Route::get('/feed-types', [HelpCenterController::class, 'getAllFeedTypes']);

        Route::post('/feed-list', [HelpCenterController::class, 'getFeedListforsingle']);
        Route::post('/all-faqs', [HelpCenterController::class, 'getAllFaqs']);
        Route::post('/all-videos', [HelpCenterController::class, 'getAllVideos']);
        Route::delete('/video/delete', [HelpCenterController::class, 'deleteVideo'])->middleware('auth:api');
        Route::delete('/faq/delete', [HelpCenterController::class, 'deleteFaq'])->middleware('auth:api');
        Route::post('/chat/users', [HelpCenterController::class, 'getUserChats'])->middleware('auth:api');
        Route::post('/chat', [HelpCenterController::class, 'addChat'])->middleware('auth:api');
        Route::get('/chat', [HelpCenterController::class, 'userChatIndividual'])->middleware('auth:api');

    });

    Route::prefix('feedback')->group(function () {
        Route::get('/', [FeedBackController::class, 'index']);         // list
        Route::get('{id}', [FeedBackController::class, 'show']);       // single
        Route::post('/', [FeedBackController::class, 'store']);        // create
        Route::patch('{id}', [FeedBackController::class, 'update']);   // update
        Route::delete('{id}', [FeedBackController::class, 'destroy']); // delete (status=0)
        Route::post('{id}/email', [FeedBackController::class, 'sendEmail']); // send email
    });


Route::prefix('testimonials')->group(function () {
    // GET /api/testimonials → Get all testimonials
    Route::get('/', [TestMonialController::class, 'index']);

    // GET /api/testimonials/{id} → Get single testimonial
    Route::get('{id}', [TestMonialController::class, 'show']);

    // POST /api/testimonials → Create new testimonial
    Route::post('/', [TestMonialController::class, 'store']);

    // PATCH /api/testimonials/{id} → Update testimonial
    Route::patch('{id}', [TestMonialController::class, 'update']);

    // DELETE /api/testimonials/{id} → Deactivate (status = 0)
    Route::delete('{id}', [TestMonialController::class, 'destroy']);

    // POST /api/testimonials/{id}/email → Send email to testimonial user
    Route::post('{id}/email', [TestMonialController::class, 'sendEmail']);
});
    // Active users
    Route::get('/users', [AllUserFetchController::class, 'getUsers']);

    // Only deleted users
    Route::get('/users/deleted', [AllUserFetchController::class, 'getDeletedUsers']);

    // Delete user by ID
    Route::delete('/users/{id}', [AllUserFetchController::class, 'deleteUser']);
    Route::get('/users/{id}', [AllUserFetchController::class, 'getStudent']);




    Route::prefix('colours')->group(function () {
        Route::get('/', [AllColorController::class, 'index']);
        Route::get('/{id}', [AllColorController::class, 'show']);
        Route::post('store', [AllColorController::class, 'store']);
        Route::patch('/{id}', [AllColorController::class, 'update']);
        Route::delete('/{id}', [AllColorController::class, 'destroy']);
    });

Route::prefix('templates')->group(function () {
    Route::get('/', [TemplatesFetchController::class, 'index']);
    Route::get('/{id}', [TemplatesFetchController::class, 'show']);
    Route::post('/', [TemplatesFetchController::class, 'store']);
    Route::patch('/{id}', [TemplatesFetchController::class, 'update']);
    Route::delete('/{id}', [TemplatesFetchController::class, 'destroy']);
});

Route::prefix('fonts')->group(function () {
    Route::get('/', [AllFontController::class, 'index']);
    Route::get('/{id}', [AllFontController::class, 'show']);
    Route::post('/', [AllFontController::class, 'store']);
    Route::patch('/{id}', [AllFontController::class, 'update']);
    Route::delete('/{id}', [AllFontController::class, 'destroy']);
});


Route::prefix('documents')->group(function () {
    Route::get('/', [UserAllDocumentController::class, 'index']);
    Route::get('/{userId}', [UserAllDocumentController::class, 'userDocuments']);
    Route::post('/{userId}', [UserAllDocumentController::class, 'store']);
    Route::patch('/{userId}/{docId}', [UserAllDocumentController::class, 'update']);
    Route::delete('/{userId}/{docId}', [UserAllDocumentController::class, 'destroy']);
});


Route::prefix('digital-cv')->group(function () {
    Route::get('/', [DigitalCvController::class, 'listUsers']);
    Route::get('/{userId}', [DigitalCvController::class, 'DigitalCv']);
});

});
