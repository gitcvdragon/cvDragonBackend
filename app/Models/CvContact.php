<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvContact extends Model
{
    protected $table = 'cv_contact'; // table name

    public $timestamps = false; // because we're using a custom 'created' column

    protected $primaryKey = 'id';

    protected $fillable = [
        'phoneNumber',
        'emailAddress',
        'location',
        'fullAddress',
        'created',
        'proofRead',
        'proofReadDate',
        'status',
        'refID',
    ];

    protected $casts = [
        'created' => 'datetime',
        'proofReadDate' => 'date',
        'proofRead' => 'boolean',
        'status' => 'integer',
        'refID' => 'integer',
    ];
}
