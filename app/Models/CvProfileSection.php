<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvProfileSection extends Model
{
     use HasFactory;

    // Table name
    protected $table = 'create-cvprofilesection';

    // Primary Key
    protected $primaryKey = 'psid';

    // Timestamps
    public $timestamps = false;

    // Fillable attributes
    protected $fillable = [
        'cvid',
        'id',
        'section',
        'subsection',
        'showName',
        'dateCreated',
        'status',
    ];

    // Casts
    protected $casts = [
        'dateCreated' => 'datetime',
        'subsection' => 'array',
    ];

    // Relationships
    public function createCvuserprofile()
    {
        return $this->belongsTo(CreateCvuserprofile::class, 'cvid','cvid');
    }
}
