<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ResourceProfileDesignCategory extends Model
{
    use HasFactory;

    protected $table = 'resource_profile_design_categories';
    protected $fillable = [
        'title',
        'slug',
        'icon',
        'status',
    ];

    public function resourceProfileDesigns()
    {
        return $this->hasMany(ResourceProfiledesign::class, 'resource_profile_design_categorie_id', 'id');
    }
}
