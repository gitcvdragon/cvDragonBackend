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
        Schema::create('cv_education', function (Blueprint $table) {
            $table->increments('eduid');
            $table->bigInteger('id')->primary();
            $table->string('category', 10);
            $table->string('institute', 100);
            $table->string('location', 100);
            $table->string('university', 100);
            $table->string('specialization', 100);
            $table->string('grade', 50);
            $table->string('score', 50);
            $table->string('year', 4)->nullable();
            $table->tinyInteger('visibility')->default(1);
            $table->timestamp('created')->useCurrent()->onUpdate(DB::raw('CURRENT_TIMESTAMP'));
            $table->tinyInteger('proofRead');
            $table->date('proofReadDate');
            $table->tinyInteger('status');
            $table->bigInteger('refID');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cv_education');
    }
};
