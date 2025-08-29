<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\Admin\User\AllUserFetchController;
use App\Http\Controllers\Api\Admin\Templates\TemplatesFetchController;
use App\Http\Controllers\Api\Admin\ResumeColors\AllColorController;
	use App\Http\Controllers\Api\Admin\Fontss\AllFontController;

Route::prefix('admin')->group(function () {
    // Active users
    Route::get('/users', [AllUserFetchController::class, 'getUsers']);

    // Only deleted users
    Route::get('/users/deleted', [AllUserFetchController::class, 'getDeletedUsers']);

    // Delete user by ID
    Route::delete('/users/{id}', [AllUserFetchController::class, 'deleteUser']);




    Route::prefix('colours')->group(function () {
        Route::get('/', [AllColorController::class, 'index']);      // list all
        Route::get('/{id}', [AllColorController::class, 'show']);   // get single
        Route::patch('/{id}', [AllColorController::class, 'update']); // update
        Route::delete('/{id}', [AllColorController::class, 'destroy']); // delete
    });

Route::prefix('templates')->group(function () {
    Route::get('/', [TemplatesFetchController::class, 'index']);
    Route::get('/{id}', [TemplatesFetchController::class, 'show']);
    Route::post('/', [TemplatesFetchController::class, 'store']);
    Route::patch('/{id}', [TemplatesFetchController::class, 'update']);
    Route::delete('/{id}', [TemplatesFetchController::class, 'destroy']);
});

Route::prefix('fonts')->group(function () {
    Route::get('/', [AllFontController::class, 'index']);     // list all
    Route::get('/{id}', [AllFontController::class, 'show']);  // get single
    Route::post('/', [AllFontController::class, 'store']);    // add
    Route::patch('/{id}', [AllFontController::class, 'update']); // edit
    Route::delete('/{id}', [AllFontController::class, 'destroy']); // delete
});


Route::prefix('documents')->group(function () {
    Route::get('/', [DocumentController::class, 'index']); // all users with summary
    Route::get('/{userId}', [DocumentController::class, 'userDocuments']); // documents of specific user
    Route::post('/{userId}', [DocumentController::class, 'store']); // upload
    Route::patch('/{userId}/{docId}', [DocumentController::class, 'update']); // edit
    Route::delete('/{userId}/{docId}', [DocumentController::class, 'destroy']); // delete
});


});
