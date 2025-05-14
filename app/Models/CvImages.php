<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvImages extends Model
{
    use HasFactory;

    protected $table = 'cv-images';

    protected $fillable = [
        'user_id',
        'image',
        'status',
    ];
}
