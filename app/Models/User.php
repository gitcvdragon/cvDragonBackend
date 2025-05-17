<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use Tymon\JWTAuth\Contracts\JWTSubject;
use Carbon\Carbon;

class User extends Authenticatable implements JWTSubject
{
    use HasApiTokens, HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $table = 'users';
    public $timestamps = false;

    protected $fillable = ['id', 'categoryid', 'affiliateID', 'socialType', 'socialid', 'authKey', 'socialToken', 'username', 'gender', 'usermobile', 'userEmail', 'userPassword', 'playerID', 'playerIDMore', 'mobilePlatform', 'appVersion', 'webLoginFlag', 'webLogin', 'appLogin', 'openCount', 'dateUpdated', 'status'];

    protected $hidden = ['otp', 'otp_expires_at'];

    protected $casts = [
        'email_verified_at' => 'datetime',
        'otp_expires_at' => 'datetime',
    ];

    public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    public function getJWTCustomClaims()
    {
        return [];
    }

    /**
     * Find or create a user based on identifier (email or phone).
     *
     * @param string $identifier
     * @return \App\Models\User
     */
    public static function findOrCreateUser($identifier)
    {
        // Determine whether the identifier is an email or phone number
        $isEmail = filter_var($identifier, FILTER_VALIDATE_EMAIL);
        $userColumn = $isEmail ? 'userEmail' : 'usermobile';

        // Check if the user already exists, otherwise create a new one
        return self::firstOrCreate(
            [$userColumn => $identifier],
            [
                'username' => 'User' . rand(1000, 9999), // Generate a random username
                'status' => 1, // Active user status
            ],
        );
    }

    public function getAppLoginAttribute($value)
    {
        return Carbon::parse($value)->format('d M, Y, g:i A'); // '10 May, 2025, 4:30 PM'
    }

    public function getDateUpdatedAttribute($value)
    {
        return Carbon::parse($value)->format('d M, Y, g:i A'); // '10 May, 2025, 4:30 PM'
    }

    public function userBasic()
    {
        return $this->hasOne(UserBasic::class, 'user_id', 'id');
    }

    public function cvProfile()
    {
        return $this->hasOne(CreateCvprofile::class, 'user_id', 'id');
    }

    public function cvSkill()
    {
        return $this->hasMany(CVSkill::class, 'user_id', 'id');
    }

    public function cvTechnical()
    {
        return $this->hasMany(CvTechnical::class, 'user_id', 'id');
    }

    public function cvLanguages()
    {
        return $this->hasMany(CvLanguages::class, 'user_id', 'id');
    }

    public function cvInterest()
    {
        return $this->hasMany(CvInterest::class, 'user_id', 'id');
    }

    public function cvBasicInfo()
    {
        return $this->hasMany(CvBasicInfo::class, 'user_id', 'id');
    }

    public function cvIntroduction()
    {
        return $this->hasMany(CvIntroduction::class, 'user_id', 'id');
    }

    public function cvAcademicProjects()
    {
        return $this->hasMany(CvAcademicProjects::class, 'user_id', 'id');
    }

    public function cvProject()
    {
        return $this->hasMany(CvProject::class, 'user_id', 'id');
    }

    public function cvPoa()
    {
        return $this->hasMany(CvPoa::class, 'user_id', 'id');
    }

    public function cvCoCurricularActivities()
    {
        return $this->hasMany(CvCoCurricularActivities::class, 'user_id', 'id');
    }

    public function cvPresentations()
    {
        return $this->hasMany(CvPresentations::class, 'user_id', 'id');
    }

    public function cvInternship()
    {
        return $this->hasMany(CvInternship::class, 'user_id', 'id');
    }

    public function cvTrainings()
    {
        return $this->hasMany(CvTrainings::class, 'user_id', 'id');
    }

    public function cvPublications()
    {
        return $this->hasMany(CvPublications::class, 'user_id', 'id');
    }

    public function cvAchievements()
    {
        return $this->hasMany(CvAchievement::class, 'user_id', 'id');
    }

    public function cvAssociation()
    {
        return $this->hasMany(CvAssociation::class, 'user_id', 'id');
    }

    public function cvVolunteer()
    {
        return $this->hasMany(CvVolunteer::class, 'user_id', 'id');
    }
}
