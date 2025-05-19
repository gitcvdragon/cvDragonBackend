<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvProject extends Model
{
    use HasFactory;

    protected $table = 'cv-project';

    protected $fillable = [
        'id',
        'workid',
        'organization',
        'title',
        'designation',
        'location',
        'duration',
        'description',
        'status',
    ];

    // Define the relationship with the User model
    public function user()
    {
        return $this->belongsTo(User::class, 'id');
    }
}
