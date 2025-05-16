<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Interest extends Model
{
    use HasFactory;
    protected $table = 'interests';

    protected $fillable = [
        'specialization_id',
        'title',
        'status',
    ];

    public function specialization()
    {
        return $this->belongsTo(Specialization::class, 'specialization_id');
    }
}
