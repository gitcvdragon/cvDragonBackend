<?php

use App\Http\Controllers\Api\Help\HelpController;
use App\Http\Controllers\Api\Menu\MenuController;

use Illuminate\Support\Facades\Route;
Route::get('/menu', [MenuController::class, 'groupByIndex']);
Route::get('/help', [HelpController::class, 'allHelp']);
