<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvIntroduction extends Model
{
    use HasFactory;

    // Define the table name explicitly (optional if the table name is the plural form of the model)
    protected $table = 'cv_introduction';

    // Define the primary key (optional if the primary key is 'id')
    protected $primaryKey = 'id';

    // Disable auto-increment (if not using auto-increment, you can set this to false)
    public $incrementing = true;

    // Define the fillable properties (to allow mass-assignment)
    protected $fillable = [
        'introid',
        'introduction',
        'title',
        'created',
        'proofRead',
        'proofReadDate',
        'status',
        'refID'
    ];

    // Define the timestamps (optional if not using created_at and updated_at)
    public $timestamps = true;

    // If you want to customize the date format, you can define the following (optional)
    protected $dates = ['created', 'proofReadDate'];
}
