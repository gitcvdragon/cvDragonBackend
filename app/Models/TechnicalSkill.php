<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TechnicalSkill extends Model
{
    use HasFactory;

    protected $table = 'technical_skills';
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
