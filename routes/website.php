<?php

use App\Http\Controllers\Api\Feed\FeedController;
use App\Http\Controllers\Api\Help\HelpController;
use App\Http\Controllers\Api\Menu\ChatController;
use App\Http\Controllers\Api\Menu\MenuController;
use App\Http\Controllers\Api\website\AllFAQController;
use App\Http\Controllers\Api\website\AllServicesController;
use App\Http\Controllers\Api\website\HomeController;
use App\Http\Controllers\Api\website\ResumeTemplatesController;
use App\Http\Controllers\Api\website\PromotionController;
use App\Http\Controllers\Api\website\PartnerInstitute;
use App\Http\Controllers\Api\website\AppDownload;
use App\Http\Controllers\Api\website\DigitalCvController;
use Illuminate\Support\Facades\Route;

Route::get('/menu', [MenuController::class, 'groupByIndex']);
Route::get('/help-videos', [HelpController::class, 'getHelpVideos']);
Route::get('/help-faq', [HelpController::class, 'getHelpFaq']);
Route::get('/help-chat', [HelpController::class, 'getNotifications']);

Route::post('/chat/add', [ChatController::class, 'addChat']);
Route::post('/chat/list', [ChatController::class, 'userChatIndividual']);

Route::get('/guideshala', [FeedController::class, 'getFeedList']);
Route::get('/guideshala/individual', [FeedController::class, 'getFeedListforsingle']);
Route::get('/home', [HomeController::class, 'fetchMarketingResources']);
Route::get('/template', [ResumeTemplatesController::class, 'templatesCategory']);
Route::get('/template/view-all', [ResumeTemplatesController::class, 'getDesignsByCategory']);
Route::get('/template/view', [ResumeTemplatesController::class, 'getDesignsByCategoryIndividual']);

Route::get('/faq/view-all', [AllFAQController::class, 'AllFaqBasedOnCategory']);
Route::get('/faq/category/view-all', [AllFAQController::class, 'AllFaqBasedOnCategorySubCategory']);

Route::get('/service-all', [AllServicesController::class, 'getServicesBlock']);
Route::get('/service/category', [AllServicesController::class, 'getServicesBlockonClick']);
Route::get('/service/category/main', [AllServicesController::class, 'getServicesBlockonClickMain']);

Route::get('/app-download', [AppDownload::class, 'appDownload']);
Route::get('/patner-institute', [PartnerInstitute::class, 'partnerInstitute']);
Route::get('/promotion', [PromotionController::class, 'promotion']);



