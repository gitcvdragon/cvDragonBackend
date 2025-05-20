<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ResourceProfilesetting extends Model
{
    use HasFactory;
    protected $table = 'resource-profilesetting';

    protected $fillable = [
        'name',
        'content',
        'heading',
        'color1',
        'color2',
        'color3',
        'color4',
        'downloadTimes',
    ];
}
