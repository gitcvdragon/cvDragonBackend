<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ResourceSecurityKeys extends Model
{
    use HasFactory;

    protected $table = 'resource-securityKeys';

    protected $fillable = [
        'assign_id',
        'assign_to',
        'security_voucher',
        'security_key',
        'design_id',
        'time_period',
        'message',
        'original_id',
        'note',
        'status',
    ];
}
