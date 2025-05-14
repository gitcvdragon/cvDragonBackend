<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ResourceSection extends Model
{
    protected $table = 'resource-section';

    // Primary key
    protected $primaryKey = 'section';
    public $incrementing = false;
    protected $keyType = 'int';
    public $timestamps = false;
    protected $fillable = ['section', 'master_cv_sections_id', 'main', 'orderSection', 'defaultSection', 'sectionContent', 'sectionContentApp', 'sectionInfoApp', 'sectionDefaultContent', 'sectionName', 'sectionLink', 'sectionTable', 'idColumnName', 'status'];
}
