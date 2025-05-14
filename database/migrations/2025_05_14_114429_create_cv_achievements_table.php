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
        Schema::create('cv-achievements', function (Blueprint $table) {
            $table->id(); // id as primary key
            $table->unsignedBigInteger('user_id'); // user_id Index
            $table->string('achievement', 255)->collation('latin1_swedish_ci'); // achievement Index
            $table->year('year'); // year Index
            $table->text('description')->collation('latin1_swedish_ci');            
            $table->tinyInteger('status');
            // Indexes
            $table->index('user_id');
            $table->index('achievement');
            $table->index('year');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cv-achievements');
    }
};
