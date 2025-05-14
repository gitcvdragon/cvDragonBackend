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
}
