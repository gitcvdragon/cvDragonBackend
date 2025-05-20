<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvBasicInfo extends Model
{
    use HasFactory;

    protected $table = 'cv-basic-info';

    protected $fillable = [
        'id',
        'cvFullName',
        'verified',
        'nationality',
        'gender',
        'dateBirth',
        'maritalStatus',
        'status',
    ];

    protected $casts = [
        'dateBirth' => 'date',
    ];

    public $timestamps = false;

    public function user()
    {
        return $this->belongsTo(User::class, 'id');
    }


}
