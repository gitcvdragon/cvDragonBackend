<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvAcademicProjects extends Model
{
    use HasFactory;

    protected $table = 'cv-academic-projects';

    protected $fillable = [
        'user_id',
        'title',
        'description',
        'status',
    ];
}
