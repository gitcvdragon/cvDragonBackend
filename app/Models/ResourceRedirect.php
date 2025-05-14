<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ResourceRedirect extends Model
{
    use HasFactory;
    protected $table = 'resource-redirect';

    protected $fillable = [
        'redirectDisplayIndex',
        'redirectHeading',
        'redirectDescription',
        'redirectLink',
        'redirectImage',
        'status',
    ];
}
