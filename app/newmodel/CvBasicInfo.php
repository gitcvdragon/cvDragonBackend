<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvBasicInfo extends Model
{
    use HasFactory;

    // Define the table name (optional, Laravel defaults to 'cv_basic_infos')
    protected $table = 'cv-basic-info';

    // Define the primary key (optional, Laravel defaults to 'id')
    protected $primaryKey = 'id';

    // Define which attributes are mass assignable
    protected $fillable = [
        'cvFullName',
        'verified',
        'nationality',
        'gender',
        'dateBirth',
        'maritalStatus',
        'facebookLink',
        'linkedinLink',
        'twitterLink',
        'blogLink',
        'dateCreated',
        'proofRead',
        'proofReadDate',
        'status',
        'refID',
    ];

    // Define the cast types for certain attributes
    protected $casts = [
        'dateBirth' => 'date',
        'dateCreated' => 'datetime',
        'proofReadDate' => 'date',
    ];

    // Disable timestamps if not using created_at / updated_at
    public $timestamps = false;
}
