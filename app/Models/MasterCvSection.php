<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MasterCvSection extends Model
{
    use HasFactory;
    protected $table = 'master_cv_sections';

    // Mass assignable attributes
    protected $fillable = ['heading', 'description', 'icon', 'color', 'status', 'ordering'];
    protected $casts = [
        'status' => 'boolean',
    ];

    public function resourceSections()
    {
        return $this->hasMany(ResourceSection::class, 'master_cv_sections_id');
    }

    
}
