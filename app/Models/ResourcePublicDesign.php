<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ResourcePublicDesign extends Model
{
    use HasFactory;

    protected $table = 'resource-publicDesign';

    protected $fillable = [
        'isPublic',
        'publicDesignName',
        'publicDesignDetails',
        'status',
    ];
}
