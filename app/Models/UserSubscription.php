<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserSubscription extends Model
{
    use HasFactory;

     protected $table = 'user-subscription';

    protected $fillable = [
        'user_id',
        'design',
        'activate',
        'expiry',
        'securityKey',
        'dateCreated',
        'dateUpdated',
        'status',
    ];
}
