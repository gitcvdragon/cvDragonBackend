<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvCoCurricularActivities extends Model
{
    use HasFactory;

    protected $table = 'cv-co-curricular-activities';

    protected $fillable = [
        'user_id',
        'title',
        'description',
        'status',
    ];
}
