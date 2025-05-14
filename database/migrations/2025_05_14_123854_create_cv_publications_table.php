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
        Schema::create('cv-publications', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('user_id')->index(); // user_id BIGINT(20) INDEX
            $table->string('title', 200)->collation('latin1_swedish_ci');
            $table->string('category', 100)->collation('latin1_swedish_ci');
            $table->string('publisher', 200)->collation('latin1_swedish_ci');
            $table->string('publishDate', 10)->collation('latin1_swedish_ci');
            $table->text('description')->collation('latin1_swedish_ci');
            $table->tinyInteger('status')->default(1); // Assuming a default value of 1 for 'status'
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cv-publications');
    }
};
