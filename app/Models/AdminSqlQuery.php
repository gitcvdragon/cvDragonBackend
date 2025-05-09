<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AdminSqlQuery extends Model
{
    // Explicit table name since it's not the default plural
    protected $table = 'admin_sql_queries';

    // Primary key name
    protected $primaryKey = 'sqlid';

    // Disable timestamps if not using created_at/updated_at
    public $timestamps = false;

    // Fillable fields for mass assignment
    protected $fillable = [
        'type',
        'title',
        'description',
        'sqlTable',
        'sqlType',
        'parameter',
        'parameterType',
        'displayType',
        'access',
        'status',
    ];
}
