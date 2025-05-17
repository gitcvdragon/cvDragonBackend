<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvPublications extends Model
{
    use HasFactory;

    protected $table = 'cv-publications';

    protected $fillable = [
        'user_id',
        'title',
        'category',
        'description',
        'publisher',
        'publishDate',
        'status',
    ];

    // Define the relationship with the User model
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
}
