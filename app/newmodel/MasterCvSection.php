<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MasterCvSection extends Model
{
    use HasFactory;

    // Table name (optional if it follows Laravel naming conventions)
    protected $table = 'master_cv_sections';

    // Mass assignable attributes
    protected $fillable = ['heading', 'description', 'icon', 'color', 'status', 'ordering'];

    // Optional: If you want to cast `status` to boolean
    protected $casts = [
        'status' => 'boolean',
    ];

    // No timestamps
    public $timestamps = false;
}
