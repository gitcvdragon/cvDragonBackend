<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CvdragonAppConfigNew extends Model
{
    // Table name
    protected $table = 'cvdragonappconfignew';

    // Primary key
    protected $primaryKey = 'configid';

    // No timestamps
    public $timestamps = false;

    // If primary key is not 'id' and is not UUID or string, set this
    protected $keyType = 'int';

    // Mass assignable fields
    protected $fillable = ['configkey', 'changesBeforeUpdate', 'version', 'configvalue', 'configvalueios', 'parameter', 'sendData'];
}
