<?php

use App\Http\Controllers\Api\Help\HelpController;
use App\Http\Controllers\Api\Menu\MenuController;
use App\Http\Controllers\Api\Menu\ChatController;
use App\Http\Controllers\Api\Feed\FeedController;
use App\Http\Controllers\Api\website\HomeController;
use App\Http\Controllers\Api\website\ResumeTemplatesController;
use App\Http\Controllers\Api\website\AllFAQController;
use Illuminate\Support\Facades\Route;



Route::get('/menu', [MenuController::class, 'groupByIndex']);
Route::get('/help', [HelpController::class, 'allHelp']);

Route::post('/chat/add', [ChatController::class, 'addChat']);
Route::post('/chat/list', [ChatController::class, 'userChatIndividual']);
Route::get('/', [FeedController::class, 'getFeedList']);
Route::get('/home', [HomeController::class, 'fetchMarketingResources']);
Route::get('/template', [ResumeTemplatesController::class, 'templatesCategory']);
Route::get('/template/view-all', [ResumeTemplatesController::class, 'getDesignsByCategory']);
Route::get('/faq/view-all', [AllFAQController::class, 'getDesignsByCategory']);
Route::get('/faq/category/view-all', [AllFAQController::class, 'getDesignsByCategory']);

