<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class HelpVideo extends Model
{
    use HasFactory;

    protected $table = 'help-videos';
    protected $primaryKey = 'videoID';
    public $timestamps = false;
    protected $fillable = [
    'heading',
    'link',
    'dateCreated',
    'web',
    'app',
    'status',
];
}
