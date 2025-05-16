<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Language extends Model
{
    use HasFactory;
    protected $table = 'languages';
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
