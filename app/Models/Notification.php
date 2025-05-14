<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Notification extends Model
{
    use HasFactory;

    protected $table = 'notifications';

    protected $fillable = [
        'heading',
        'description',
        'displayImage',
        'insideImage',
        'showNote',
        'thankNote',
        'type',
        'link',
        'linkHeading',
        'formDisplay',
        'notificationCategory',
        'version',
        'status',
    ];
}
