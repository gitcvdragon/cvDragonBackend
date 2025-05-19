<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ResourceSection extends Model
{
    use HasFactory;
    protected $table = 'resource-section';

    protected $fillable = [
        'master_cv_sections_id',
        'main',
        'orderSection',
        'defaultSection',
        'sectionContent',
        'sectionContentApp',
        'sectionInfoApp',
        'sectionDefaultContent',
        'sectionName',
        'sectionLink',
        'sectionTable',
        'idColumnName',
        'status',
    ];

    public function masterCvSection()
    {
        return $this->belongsTo(MasterCvSection::class, 'master_cv_sections_id');
    }

    // public function sectionQuestions()
    // {
    //     return $this->hasMany(SectionQuestion::class, 'resource_section_id', 'id');
    // }

    public function sectionQuestions()
    {
        return $this->hasMany(SectionQuestion::class, 'resource_section_id')
                    ->whereNull('dependent_on_question_id') 
                    ->where('status', 1)
                    ->orderBy('ordering');
    }


   
}
