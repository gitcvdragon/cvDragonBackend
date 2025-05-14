<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ResourceLink extends Model
{
    use HasFactory;
    protected $table = 'resource-links';

    protected $fillable = [
        'linkOrder',
        'linkHeading',
        'linkDetails',
        'status',
    ];
}
