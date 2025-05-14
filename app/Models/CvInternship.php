<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvInternship extends Model
{
    use HasFactory;

     protected $table = 'cv-internship';

    protected $fillable = [
        'organization',
        'user_id',
        'title',
        'designation',
        'duration',
        'location',
        'description',
        'status',
    ];
}
