<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CVSkill extends Model
{
    use HasFactory;

    protected $table = 'cv-skills';
    protected $fillable = [
        'user_id',
        'skill',
        'description',
        'status',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
