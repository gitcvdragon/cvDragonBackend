<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('cv-introduction', function (Blueprint $table) {
            $table->increments('introid');
            $table->bigInteger('id');
            $table->text('introduction'); 
            $table->string('title', 255); 
            $table->smallInteger('status')->default(1)->comment('0=inactive, 1=active'); 
            $table->timestamps('created'); 
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cv-introduction');
    }
};
