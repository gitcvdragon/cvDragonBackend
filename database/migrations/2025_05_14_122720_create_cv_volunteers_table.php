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
        Schema::create('cv-volunteer', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id');
            $table->string('organization', 50)->collation('latin1_swedish_ci');
            $table->string('cause', 50)->collation('latin1_swedish_ci');
            $table->string('role', 50)->collation('latin1_swedish_ci');
            $table->date('dateJoining')->nullable();
            $table->date('dateLeaving')->nullable();
            $table->tinyInteger('present');
            $table->text('description')->collation('latin1_swedish_ci');
            $table->tinyInteger('status');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cv-volunteer');
    }
};
