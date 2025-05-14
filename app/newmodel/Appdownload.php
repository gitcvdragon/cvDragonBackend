<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Appdownload extends Model
{
    protected $primaryKey = 'appID'; // Set custom primary key
    public $timestamps = false;      // If you are not using created_at/updated_at

    protected $fillable = [
        'referralCode',
        'ipAddress',
        'referer',
        'dateTime',
        'status',
    ];
}
