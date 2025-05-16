<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserCategory extends Model
{
    use HasFactory;

    public function user()
    {
        return $this->hasOne(User::class, 'categoryid', 'id');
    }
}
