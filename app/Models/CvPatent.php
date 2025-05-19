<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvPatent extends Model
{
    use HasFactory;

    protected $table = 'cv-patent';

    protected $fillable = [
        'id',
        'title',
        'patentOffice',
        'patentStatus',
        'patentApplication',
        'patentDate',
        'description',
        'status',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'id');
    }
}
