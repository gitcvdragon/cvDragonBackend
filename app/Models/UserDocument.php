<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserDocument extends Model
{
    use HasFactory;

    protected $table = 'user-documents';

    protected $fillable = [
        'documentTitle',
        'documentLocation',
        'documentSection',
        'documentSubSection',
        'id',
        'date',
        'status',
    ];
}
