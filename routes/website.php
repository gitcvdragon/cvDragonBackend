<?php

use App\Http\Controllers\Api\Help\HelpController;
use App\Http\Controllers\Api\Menu\MenuController;
use App\Http\Controllers\Api\Menu\ChatController;
use App\Http\Controllers\Api\Feed\FeedController;
use Illuminate\Support\Facades\Route;



Route::get('/menu', [MenuController::class, 'groupByIndex']);
Route::get('/help', [HelpController::class, 'allHelp']);

Route::post('/chat/add', [ChatController::class, 'addChat']);
Route::post('/chat/list', [ChatController::class, 'userChatIndividual']);
Route::get('/feeds', [FeedController::class, 'getFeedList']);

