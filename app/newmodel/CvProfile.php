<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvProfile extends Model
{
    use HasFactory;

    // Specify the table name
    protected $table = 'cvprofiles';

    // Specify the primary key and composite key
    protected $primaryKey = ['id', 'profileName', 'sections', 'status'];

    // Disable incrementing because the primary key is composite
    public $incrementing = false;

    // Specify the type of the primary key
    protected $keyType = 'string';

    // The attributes that are mass assignable
    protected $fillable = [
        'id', 'profileName', 'sections', 'sectionOrder', 'design', 'font',
        'setting', 'profilePicture', 'intro', 'isPublic', 'progressReport', 'dateUpdated', 'status'
    ];
}
