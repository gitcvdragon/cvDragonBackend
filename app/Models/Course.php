<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Course extends Model
{
    use HasFactory;


    protected $fillable = [
        'resource_carrer_id',
        'title',
        'status',
    ];

    public function resourceCarrer()
    {
        return $this->belongsTo(ResourceCarrer::class, 'resource_carrer_id');
    }

    public function specializations()
    {
        return $this->hasMany(Specialization::class, 'course_id');
    }
}
