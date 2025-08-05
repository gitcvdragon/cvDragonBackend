<?php

use App\Http\Controllers\AppConfigController;
use App\Http\Controllers\CvCommonController;
use App\Http\Controllers\CvDesignController;
use App\Http\Controllers\CvProfileController;
use App\Http\Controllers\CvSectionController;
use App\Http\Controllers\OTPAuthController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\Api\Menu\MenuController;

use Illuminate\Support\Facades\Route;
Route::get('/menu', [MenuController::class, 'groupByIndex']);
