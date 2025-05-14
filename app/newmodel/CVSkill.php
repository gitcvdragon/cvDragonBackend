<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CVSkill extends Model
{
    use HasFactory;

    // The table associated with the model.
    protected $table = 'cv-skills';

    // The primary key associated with the table.
    protected $primaryKey = 'skillid';

    // Indicates if the model should be timestamped.
     public $timestamps = true;// 

    // The attributes that are mass assignable.
    protected $fillable = [
        'skill',
        'description',
        'created',
        'proofRead',
        'proofReadDate',
        'masterID',
        'status',
        'refID',
    ];

    // The attributes that should be cast to native types.
    protected $casts = [
        'proofRead' => 'integer',
        'proofReadDate' => 'date',
        'created' => 'datetime',
    ];

    // If CVSkill has any relationship, you can define them here.
    // Example: 
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
