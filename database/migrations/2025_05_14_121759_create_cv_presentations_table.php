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
        Schema::create('cv_presentations', function (Blueprint $table) {
             $table->id(); // id INT AUTO_INCREMENT PRIMARY KEY
            $table->unsignedBigInteger('user_id');
            $table->string('title', 200)->collation('latin1_swedish_ci');
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
        Schema::dropIfExists('cv_presentations');
    }
};
