<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserBasic extends Model
{
    use HasFactory;

    protected $table = 'user-basic';
  public $timestamps = false;
    protected $fillable = ['id', 'fullName', 'gender', 'emailAddress', 'countryCode', 'phoneNumber', 'profileImageUrl', 'profileVideoURL', 'publicProfileStatus', 'publicProfile', 'publicProfileDesign', 'iconList', 'showFAQ', 'showKey', 'showDatabase', 'DND', 'DNE', 'DNW', 'notiHelp', 'notiDesign', 'notiPlacement', 'notiOther', 'showMobile', 'showProfile', 'showEmail', 'sendEmailStatus', 'isInternational', 'showDelete', 'showWizard', 'wizardWorkExp', 'wizardEducationProfile', 'wizardWorkProfile', 'wizardEducationSpecialization', 'wizardWorkSpecialization', 'showFeatureFreeSubscription', 'showFeatureReview', 'showFeatureInstitute', 'showFeatureMyResume', 'showFeatureNotification', 'showFeatureWorkshops', 'showFeatureKC', 'showFeaturePublicProfile', 'showFeatureJobs', 'showFeatureResources', 'showFeatureTips', 'showFeatureArticles', 'showFeatureFAQs', 'showFeatureReorder', 'showOptionFeedback', 'status'];

    public function user()
    {
        return $this->belongsTo(User::class, 'id');
    }


}
