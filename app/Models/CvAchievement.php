<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvAchievement extends Model
{
    use HasFactory;

    protected $table = 'cv-achievements';

    public $timestamps = false; // custom timestamp column used instead

    protected $fillable = [
        'id',
        'achievement',
        'year',
        'description',
        'status',
    ];

    // Define the relationship with the User model
    public function user()
    {
        return $this->belongsTo(User::class, 'id');
    }
}
