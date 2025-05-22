<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvContact extends Model
{
    protected $table = 'cv-contact'; // table name

    public $timestamps = false; // because we're using a custom 'created' column

    protected $fillable = [
        'id',
        'phoneNumber',
        'emailAddress',
        'location',
        'fullAddress',
        'status',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'id');
    }
}
