<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvLanguages extends Model
{
    use HasFactory;

     protected $table = 'cv-languages';

    protected $fillable = [
        'id',
        'language',
        'readLanguage',
        'writeLanguage',
        'speakLanguage',
        'status',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'id');
    }
}
