<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class HelpChat extends Model
{
    use HasFactory;

    protected $table = 'help-chat';

     protected $fillable = [
        'senderID',
        'receiverID',
        'chat',
        'type',
        'isResolved',
        'adminID',
        'status',
    ];

    public $timestamps = false;
}
