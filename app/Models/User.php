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

    protected $fillable = ['id', 'categoryid', 'affiliateID', 'socialType', 'socialid', 'authKey', 'socialToken', 'username', 'gender', 'usermobile', 'userEmail', 'playerID', 'playerIDMore', 'mobilePlatform', 'appVersion',  'openCount', 'dateUpdated', 'status'];

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

    // public function getAppLoginAttribute($value)
    // {
    //     return Carbon::parse($value)->format('d M, Y, g:i A'); // '10 May, 2025, 4:30 PM'
    // }

    public function getDateUpdatedAttribute($value)
    {
        return Carbon::parse($value)->format('d M, Y, g:i A'); // '10 May, 2025, 4:30 PM'
    }

    public function userBasic()
    {
        return $this->hasOne(UserBasic::class, 'id', 'id');
    }

    public function cvProfile()
    {
        return $this->hasOne(CreateCvprofile::class, 'id', 'id');
    }

    public function cvSkill()
    {
        return $this->hasMany(CVSkill::class, 'id', 'id');
    }

    public function cvTechnical()
    {
        return $this->hasMany(CvTechnical::class, 'id', 'id');
    }

    public function cvLanguages()
    {
        return $this->hasMany(CvLanguages::class, 'id', 'id');
    }

    public function cvInterest()
    {
        return $this->hasMany(CvInterest::class, 'id', 'id');
    }

    public function cvBasicInfo()
    {
        return $this->hasMany(CvBasicInfo::class, 'user_id', 'id');
    }

    public function cvIntroduction()
    {
        return $this->hasMany(CvIntroduction::class, 'id', 'id');
    }

    public function cvAcademicProjects()
    {
        return $this->hasMany(CvAcademicProjects::class, 'id', 'id');
    }

    public function cvProject()
    {
        return $this->hasMany(CvProject::class, 'id', 'id');
    }

    public function cvPoa()
    {
        return $this->hasMany(CvPoa::class, 'id', 'id');
    }

    public function cvCoCurricularActivities()
    {
        return $this->hasMany(CvCoCurricularActivities::class, 'id', 'id');
    }

    public function cvPresentations()
    {
        return $this->hasMany(CvPresentations::class, 'id', 'id');
    }

    public function cvInternship()
    {
        return $this->hasMany(CvInternship::class, 'id', 'id');
    }

    public function cvTrainings()
    {
        return $this->hasMany(CvTrainings::class, 'id', 'id');
    }

    public function cvPublications()
    {
        return $this->hasMany(CvPublications::class, 'id', 'id');
    }

    public function cvAchievements()
    {
        return $this->hasMany(CvAchievement::class, 'id', 'id');
    }

    public function cvAssociation()
    {
        return $this->hasMany(CvAssociation::class, 'id', 'id');
    }

    public function cvVolunteer()
    {
        return $this->hasMany(CvVolunteer::class, 'id', 'id');
    }
}
