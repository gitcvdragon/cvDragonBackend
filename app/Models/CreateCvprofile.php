<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CreateCvprofile extends Model
{
    protected $table = 'create-cvprofile'; // Explicitly define table name

    protected $primaryKey = 'cvid'; // Define custom primary key

    public $timestamps = false; // Disable default timestamps if you're using custom ones

    protected $fillable = [
        'cvid',
        'id',
        'profileName',
        'sections',
        'sectionOrder',
        'design',
        'font',
        'setting',
        'profilePicture',
        'intro',
        'isPublic',
        'progressReport',
        'dateUpdated',
        'status',
    ];
}
