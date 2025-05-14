<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvLanguages extends Model
{
    use HasFactory;

     protected $table = 'cv-languages';

    protected $fillable = [
        'refID',
        'user_id',
        'language',
        'readLanguage',
        'writeLanguage',
        'speakLanguage',
        'status',
    ];
}
