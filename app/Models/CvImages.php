<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvImages extends Model
{
    use HasFactory;

    protected $table = 'cv-images';

    protected $fillable = [
        'id',
        'image',
        'status'
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', 'id');
    }

    public function CreateCvuserprofile()
    {
        return $this->hasMany(CreateCvuserprofile::class, 'profilePicture', 'imageid');
    }
}
