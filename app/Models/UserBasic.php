<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserBasic extends Model
{
    use HasFactory;

    protected $table = 'user-basic';

    protected $fillable = ['id', 'fullName', 'emailAddress', 'countryCode', 'phoneNumber', 'profileImageUrl', 'profileVideoURL', 'publicProfileStatus', 'publicProfile', 'publicProfileDesign', 'iconList', 'showFAQ', 'showKey', 'showDatabase', 'DND', 'DNE', 'DNW', 'notiHelp', 'notiDesign', 'notiPlacement', 'notiOther', 'showMobile', 'showProfile', 'showEmail', 'sendEmailStatus', 'isInternational', 'showDelete', 'showWizard', 'wizardProfile', 'wizardWorkExp', 'wizardEducationProfile', 'wizardWorkProfile', 'wizardEducationSpecialization', 'wizardWorkSpecialization', 'showFeatureFreeSubscription', 'showFeatureReview', 'showFeatureInstitute', 'showFeatureMyResume', 'showFeatureNotification', 'showFeatureWorkshops', 'showFeatureKC', 'showFeaturePublicProfile', 'showFeatureJobs', 'showFeatureResources', 'showFeatureTips', 'showFeatureArticles', 'showFeatureFAQs', 'showFeatureReorder', 'showOptionFeedback', 'dateCreated', 'status'];

     // Disable timestamps if not using created_at / updated_at
    public $timestamps = false;
}
