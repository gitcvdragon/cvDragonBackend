<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvAcademicProjects extends Model
{
    use HasFactory;

    protected $table = 'cv-academic-projects';

    protected $fillable = [
        'id',
        'title',
        'description',
        'status',
    ];

    // Define the relationship with the User model
    public function user()
    {
        return $this->belongsTo(User::class, 'id');
    }
}
