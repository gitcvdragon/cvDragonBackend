<?php

use App\Http\Controllers\OTPAuthController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('welcome' );
});
Route::get('/auth/google', [OTPAuthController::class, 'redirectToGoogle'])->name('google.loginn');
Route::get('/auth/google/callback', [OTPAuthController::class, 'handleGoogleCallback']);

Route::get('/auth/linkdin', [OTPAuthController::class, 'redirectToLinkedin'])->name('linkdin.loginn');
Route::get('/auth/linkdin-openid/callback', [OTPAuthController::class, 'handleLinkdinCallback']);