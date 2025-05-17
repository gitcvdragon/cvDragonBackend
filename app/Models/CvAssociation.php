<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvAssociation extends Model
{
    use HasFactory;

    protected $table = 'cv-association';

    protected $fillable = [
        'user_id',
        'organization',
        'position',
        'location',
        'description',
        'dateJoining',
        'dateLeaving',
        'present',
        'status',
    ];

    // Define the relationship with the User model
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
}
