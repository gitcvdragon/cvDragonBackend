<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\Admin\User\AllUserFetchController;

Route::prefix('admin')->group(function () {
    Route::get('/users', [AllUserFetchController::class, 'getUsers']);
});
