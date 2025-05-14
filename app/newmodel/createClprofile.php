<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class createClprofile extends Model
{
    protected $table = 'clprofiles';
    protected $primaryKey = 'clid';
    public $timestamps = false;

    protected $fillable = [
        'cvid',
        'id',
        'design',
        'coverName',
        'coverLetter',
        'dateCreated',
        'status',
    ];
}
