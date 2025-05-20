<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserVoucherDetails extends Model
{
    use HasFactory;
    protected $table = 'uservoucherdetails';
    public $timestamps = false;
    protected $primaryKey = 'sn';
    protected $fillable = [
        'id',
        'userName',
        'userEmail',
        'userPhone',
        'userInstitute',
        'userInstituteID',
        'userLocation',
        'userEducation',
        'userPassYear',
        'voucherSN',
        'voucherCode',
        'voucherDesign',
        'voucherDuration',
        'notify',
        'notifyDetails',
        'status',
    ];
}
