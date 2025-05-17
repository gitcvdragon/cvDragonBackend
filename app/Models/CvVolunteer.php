<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvVolunteer extends Model
{
    use HasFactory;

    protected $table = 'cv-volunteer';

    protected $fillable = [
        'user_id',
        'organization',
        'cause',
        'role',
        'dateJoining',
        'dateLeaving',
        'present',
        'description',
        'status',
    ];

    // Define the relationship with the User model
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
}
