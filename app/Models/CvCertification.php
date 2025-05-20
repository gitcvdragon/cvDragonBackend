<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvCertification extends Model
{
    use HasFactory;

    protected $table = 'cv-certification';
    protected $primaryKey = 'certificateid';

    public $timestamps = false;

    protected $fillable = [
        'id',
        'certificate',
        'authority',
        'year',
    ];

     public function user()
    {
        return $this->belongsTo(User::class, 'id');
    }

}
