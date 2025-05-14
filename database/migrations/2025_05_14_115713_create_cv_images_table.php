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
            $table->id(); // AUTO_INCREMENT id
            $table->unsignedBigInteger('user_id');
            $table->string('image', 100)->collation('latin1_swedish_ci');
            $table->tinyInteger('status');

            $table->index('id');
            $table->timestamps();
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
