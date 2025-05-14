<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvCertification extends Model
{
    use HasFactory;

    protected $table = 'cv-certification';

    public $timestamps = false;

    protected $fillable = [
        'user_id',
        'certificate',
        'authority',
        'year',
        'status',
    ];

}
