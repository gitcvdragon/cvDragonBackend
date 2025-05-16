<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('user-basic', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('user_id');
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
            $table->string('fullName', 100)->nullable(); // Allow NULL for fullName
            $table->string('gender', 10)->nullable(); // Allow NULL for fullName
            $table->string('emailAddress', 200)->nullable(); // Allow NULL for emailAddress
            $table->integer('countryCode')->nullable(); // Allow NULL for countryCode
            $table->unsignedBigInteger('phoneNumber')->nullable(); // Allow NULL for phoneNumber
            $table->text('profileImageUrl')->nullable(); // Allow NULL for profileImageUrl
            $table->string('profileVideoURL', 200)->nullable(); // Allow NULL for profileVideoURL
            $table->integer('publicProfileStatus')->nullable(); // Allow NULL for publicProfileStatus
            $table->integer('publicProfile')->nullable(); // Allow NULL for publicProfile
            $table->integer('publicProfileDesign')->nullable(); // Allow NULL for publicProfileDesign
            $table->tinyInteger('iconList')->nullable(); // Allow NULL for iconList
            $table->tinyInteger('showFAQ')->nullable(); // Allow NULL for showFAQ
            $table->tinyInteger('showKey')->nullable(); // Allow NULL for showKey
            $table->tinyInteger('showDatabase')->nullable(); // Allow NULL for showDatabase
            $table->tinyInteger('DND')->nullable(); // Allow NULL for DND
            $table->tinyInteger('DNE')->nullable(); // Allow NULL for DNE
            $table->tinyInteger('DNW')->nullable(); // Allow NULL for DNW
            $table->tinyInteger('notiHelp')->nullable(); // Allow NULL for notiHelp
            $table->tinyInteger('notiDesign')->nullable(); // Allow NULL for notiDesign
            $table->tinyInteger('notiPlacement')->nullable(); // Allow NULL for notiPlacement
            $table->tinyInteger('notiOther')->nullable(); // Allow NULL for notiOther
            $table->tinyInteger('showMobile')->nullable(); // Allow NULL for showMobile
            $table->tinyInteger('showProfile')->nullable(); // Allow NULL for showProfile
            $table->tinyInteger('showEmail')->nullable(); // Allow NULL for showEmail
            $table->integer('sendEmailStatus')->nullable(); // Allow NULL for sendEmailStatus
            $table->tinyInteger('isInternational')->nullable(); // Allow NULL for isInternational
            $table->tinyInteger('showDelete')->nullable(); // Allow NULL for showDelete
            $table->tinyInteger('showWizard')->nullable(); // Allow NULL for showWizard
            $table->integer('wizardProfile')->nullable(); // Allow NULL for wizardProfile
            $table->integer('wizardWorkExp')->nullable(); // Allow NULL for wizardWorkExp
            $table->string('wizardEducationProfile', 255)->nullable(); // Allow NULL for wizardEducationProfile
            $table->string('wizardWorkProfile', 255)->nullable(); // Allow NULL for wizardWorkProfile
            $table->string('wizardEducationSpecialization', 255)->nullable(); // Allow NULL for wizardEducationSpecialization
            $table->string('wizardWorkSpecialization', 255)->nullable(); // Allow NULL for wizardWorkSpecialization
            $table->tinyInteger('showFeatureFreeSubscription')->nullable(); // Allow NULL for showFeatureFreeSubscription
            $table->tinyInteger('showFeatureReview')->nullable(); // Allow NULL for showFeatureReview
            $table->tinyInteger('showFeatureInstitute')->nullable(); // Allow NULL for showFeatureInstitute
            $table->tinyInteger('showFeatureMyResume')->nullable(); // Allow NULL for showFeatureMyResume
            $table->tinyInteger('showFeatureNotification')->nullable(); // Allow NULL for showFeatureNotification
            $table->integer('showFeatureWorkshops')->nullable(); // Allow NULL for showFeatureWorkshops
            $table->integer('showFeatureKC')->nullable(); // Allow NULL for showFeatureKC
            $table->tinyInteger('showFeaturePublicProfile')->nullable(); // Allow NULL for showFeaturePublicProfile
            $table->integer('showFeatureJobs')->nullable(); // Allow NULL for showFeatureJobs
            $table->integer('showFeatureResources')->nullable(); // Allow NULL for showFeatureResources
            $table->integer('showFeatureTips')->nullable(); // Allow NULL for showFeatureTips
            $table->integer('showFeatureArticles')->nullable(); // Allow NULL for showFeatureArticles
            $table->integer('showFeatureFAQs')->nullable(); // Allow NULL for showFeatureFAQs
            $table->integer('showFeatureReorder')->nullable(); // Allow NULL for showFeatureReorder
            $table->integer('showOptionFeedback')->nullable(); // Allow NULL for showOptionFeedback
            $table->softDeletes(); // adds deleted_at column
            $table->timestamps(); 
            
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('user_basic');
    }
};
