<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvInternship extends Model
{
    use HasFactory;

     protected $table = 'cv-internship';

    protected $fillable = [
        'user_id',
        'organization',
        'title',
        'designation',
        'duration',
        'location',
        'description',
        'status',
    ];

    // Define the relationship with the User model
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
}
