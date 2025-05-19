<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvTechnical extends Model
{
    use HasFactory;

     protected $table = 'cv-technical';
    protected $fillable = [
        'id',
        'technical',
        'status',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'id');
    }
}
