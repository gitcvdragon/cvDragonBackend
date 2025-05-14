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
        'user_id',
        'achievement',
        'year',
        'description',
        'status',
    ];
}
