<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvPreference extends Model
{
    use HasFactory;

    protected $table = 'cv-preference'; // Table name

    protected $primaryKey = 'prefid'; // Primary key field

    public $timestamps = false; // Disable automatic timestamp management (since you're using custom timestamps)

    protected $fillable = [
        'id',
        'passport',
        'passportDetails',
        'recommendations',
        'preferredLocation',
        'canRelocate',
        'noticePeriod',
        'canJoin',
        'expectedCTC',
        'isNegotiate',
        'declaration',
        'signature',
        'created',
        'status',
    ];

    protected $casts = [
        'created' => 'datetime',
    ];

    // Define any relationships if needed
    public function user()
    {
        return $this->belongsTo(User::class, 'id');
    }
}
