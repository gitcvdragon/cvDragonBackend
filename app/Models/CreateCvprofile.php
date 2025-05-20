<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CreateCvprofile extends Model
{
    protected $table = 'cvprofiles'; // Explicitly define table name

    protected $fillable = [
        'id',
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
}
