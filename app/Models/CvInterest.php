<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvInterest extends Model
{
    use HasFactory;

    protected $table = 'cv-interests';

    protected $fillable = [
        'id',
        'interest',
        'level',
        'status',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'id');
    }
}
