<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvTrainings extends Model
{
    use HasFactory;

    protected $table = 'cv-trainings';
    protected $fillable = [
        'id',
        'training',
        'description',
        'number',
        'status',
    ];
    // Define the relationship with the User model
    public function user()
    {
        return $this->belongsTo(User::class, 'id');
    }
}
