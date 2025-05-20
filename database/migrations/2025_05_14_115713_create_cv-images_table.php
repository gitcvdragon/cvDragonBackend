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
        Schema::create('cv-images', function (Blueprint $table) {
            $table->increments('imageid');
            $table->bigInteger('id'); 
            $table->string('image', 100);
            $table->tinyInteger('status')->default(1)->comment('1=active,0=inactive');

            $table->index('id');
            $table->timestamps('created');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cv-images');
    }
};
