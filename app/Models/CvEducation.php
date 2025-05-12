<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvEducation extends Model
{
    use HasFactory;

    protected $table = 'cv_education';

    protected $primaryKey = 'eduid';

    public $timestamps = true; // Since you have created_at and updated_at columns

    protected $fillable = [
        'id',
        'category',
        'institute',
        'location',
        'university',
        'specialization',
        'grade',
        'score',
        'year',
        'visibility',
        'created',
        'proofRead',
        'proofReadDate',
        'status',
        'refID',
    ];
}
