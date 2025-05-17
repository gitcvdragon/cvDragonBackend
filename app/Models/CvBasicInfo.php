<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvBasicInfo extends Model
{
    use HasFactory;

    // Define the table name (optional, Laravel defaults to 'cv_basic_infos')
    protected $table = 'cv-basic-info';

    // Define which attributes are mass assignable
    protected $fillable = [
        'user_id',
        'cvFullName',
        'verified',
        'nationality',
        'gender',
        'dateBirth',
        'maritalStatus',
        'status',
    ];

    // Define the cast types for certain attributes
    protected $casts = [
        'dateBirth' => 'date',
    ];

    // Define the relationship with the User model
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }


}
