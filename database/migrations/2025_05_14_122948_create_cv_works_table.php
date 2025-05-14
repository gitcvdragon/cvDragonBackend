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
        Schema::create('cv-work', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id');
            $table->string('organization', 200)->collation('latin1_swedish_ci');
            $table->string('designation', 200)->collation('latin1_swedish_ci');
            $table->string('location', 100)->collation('latin1_swedish_ci');
            $table->date('dateJoined');
            $table->date('dateResigned')->nullable();
            $table->tinyInteger('currentWorking');
            $table->text('workProfile')->collation('latin1_swedish_ci');
            $table->tinyInteger('status');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cv-work');
    }
};
