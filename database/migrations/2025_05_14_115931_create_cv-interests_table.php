<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('cv-interests', function (Blueprint $table) {
           $table->increments('interestid');
            $table->bigInteger('id');
            $table->text('interest');
             $table->text('level')->nullable();
            $table->tinyInteger('status')->default(1)->comment('1 = active, 0 = inactive'); 
            $table->timestamps('created');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cv-interests');
    }
};
