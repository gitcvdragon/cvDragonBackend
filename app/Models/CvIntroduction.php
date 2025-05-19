<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvIntroduction extends Model
{
    use HasFactory;

    // Define the table name explicitly (optional if the table name is the plural form of the model)
    protected $table = 'cv-introduction';


    // Define the fillable properties (to allow mass-assignment)
    protected $fillable = [
        'id',
        'introduction',
        'title',
        'status',
    ];

    // Define the relationship with the User model
    public function user()
    {
        return $this->belongsTo(User::class, 'id');
    }



}
