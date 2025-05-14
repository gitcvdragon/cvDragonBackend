<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvInterest extends Model
{
    use HasFactory;

    protected $table = 'cv-interests';

    public $timestamps = false;

    protected $fillable = [
        'user_id',
        'interest',
        'status',
    ];
}
