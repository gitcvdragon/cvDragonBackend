<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SectionQuestion extends Model
{
    use HasFactory;

    protected $table = 'section_questions';

    protected $fillable = [
        'resource_section_id',
        'question',
        'question_type',
        'is_dependent',
        'required',
        'dependent_on_question_id',
        'triggering_answer',
        'ordering',
        'status',
    ];

    protected $casts = [
        'is_dependent' => 'boolean',
        'required' => 'boolean',
        'status' => 'boolean',
        'options' => 'array',
    ];

    public function resourceSection()
    {
        return $this->belongsTo(ResourceSection::class, 'resource_section_id');
    }

   public function dependentQuestions()
    {
        return $this->hasMany(SectionQuestion::class, 'dependent_on_question_id');
    }

}
