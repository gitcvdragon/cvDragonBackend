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
        Schema::create('cv-co-curricular-activities', function (Blueprint $table) {
            $table->id(); // AUTO_INCREMENT
            $table->unsignedBigInteger('user_id'); // Primary composite
            $table->string('title', 100)->collation('latin1_swedish_ci'); // Primary composite
            $table->text('description')->collation('latin1_swedish_ci');
            $table->smallInteger('status');

            $table->index('id');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cv-co-curricular-activities');
    }
};
