<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvWork extends Model
{
    use HasFactory;

    protected $table = 'cv-work';

    protected $fillable = [
        'id',
        'organization',
        'designation',
        'location',
        'dateJoined',
        'dateResigned',
        'currentWorking',
        'workProfile',
        'status',
    ];

     public function user()
    {
        return $this->belongsTo(User::class, 'id');
    }
}
