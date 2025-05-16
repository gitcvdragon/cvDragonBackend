<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CreateCvuserprofile extends Model
{
    protected $table = 'create-cvprofile'; // Explicitly define table name

    protected $fillable = [
        'user_id',
        'profileName',
        'sectionOrder',
        'design',
        'font',
        'setting',
        'profilePicture',
        'intro',
        'isPublic',
        'progressReport',
        'status',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function cvImages()
    {
        return $this->belongsTo(CvImages::class, 'profilePicture', 'id');
    }
}
