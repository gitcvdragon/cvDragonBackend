<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ResourceProfilefont extends Model
{
    use HasFactory;
    protected $table = 'resource-profilefont';

    protected $fillable = [
        'fontTypeName',
        'fontType',
        'googleFontName',
        'fontSize',
        'appliedOn',
        'downloadTime',
        'web',
        'app',
        'status'
    ];
}
