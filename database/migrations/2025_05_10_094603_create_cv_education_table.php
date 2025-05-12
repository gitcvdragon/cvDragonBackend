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
        Schema::create('cv-education', function (Blueprint $table) {
            $table->increments('eduid');
            $table->bigInteger('id');
            $table->string('category', 10);
            $table->string('institute', 100)->nullable();
            $table->string('location', 100)->nullable();
            $table->string('university', 100)->nullable();
            $table->string('specialization', 100)->nullable();
            $table->string('grade', 50)->nullable();
            $table->string('score', 50)->nullable();
            $table->string('year', 4)->nullable();
            $table->tinyInteger('visibility')->default(1);
            $table->timestamp('created')->useCurrent()->onUpdate(DB::raw('CURRENT_TIMESTAMP'));
            $table->tinyInteger('proofRead')->nullable();
            $table->date('proofReadDate')->nullable();
            $table->tinyInteger('status')->nullable();
            $table->bigInteger('refID')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cv-education');
    }
};
