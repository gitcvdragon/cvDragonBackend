<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\Admin\User\AllUserFetchController;
use App\Http\Controllers\Api\Admin\Templates\TemplatesFetchController;
use App\Http\Controllers\Api\Admin\ResumeColors\AllColorController;
use App\Http\Controllers\Api\Admin\Fontss\AllFontController;
use App\Http\Controllers\Api\Admin\Documents\UserAllDocumentController;
use App\Http\Controllers\Api\Admin\DigitalCv\DigitalCvController;


Route::prefix('admin')->group(function () {
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
