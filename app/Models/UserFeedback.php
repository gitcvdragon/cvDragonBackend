<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserFeedback extends Model
{
    use HasFactory;
    protected $table = 'user-feedback';

    protected $fillable = [
        'id',
        'userName',
        'userPhone',
        'userEmail',
        'feedback',
        'rating',
        'isResolved',
        'dateResolved',
        'dateCreated',
        'mode',
        'status',
    ];
}
