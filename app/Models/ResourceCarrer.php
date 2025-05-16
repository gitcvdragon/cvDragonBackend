<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ResourceCarrer extends Model
{
    use HasFactory;

    protected $table = 'resource_carrers';

    protected $fillable = [
        'title',
        'status',
        'description',
    ];

    public function courses()
    {
        return $this->hasMany(Course::class, 'resource_carrer_id');
    }
}
