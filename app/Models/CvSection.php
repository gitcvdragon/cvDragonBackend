<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvSection extends Model
{
   use HasFactory;

    // Define the table associated with the model
    protected $table = 'cvsections';

    // Define the primary key for the model (if it's not the default 'id')
    protected $primaryKey = 'id';

    // Disable automatic timestamps if you do not want the default `created_at` and `updated_at` columns
    public $timestamps = true;

    // Set the attributes that are mass assignable
    protected $fillable = [
        'sectionid',
        'section',
        'contentAdded',
        'contentStatus',
        'dateCreated',
        'status',
    ];
}
