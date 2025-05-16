<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Specialization extends Model
{
    use HasFactory;

    protected $table = 'specializations';

    protected $fillable = [
        'course_id',
        'title',
        'status',
    ];

    public function course()
    {
        return $this->belongsTo(Course::class, 'course_id');
    }

    public function skills()
    {
        return $this->hasMany(Skill::class, 'specialization_id');
    }

    public function technicalSkills()
    {
        return $this->hasMany(TechnicalSkill::class, 'specialization_id');
    }

    public function languages()
    {
        return $this->hasMany(Language::class, 'specialization_id');
    }

    public function interests()
    {
        return $this->hasMany(Interest::class, 'specialization_id');
    }
}
