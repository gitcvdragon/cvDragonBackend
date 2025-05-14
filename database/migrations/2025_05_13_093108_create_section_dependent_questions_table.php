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
        Schema::create('section_dependent_questions', function (Blueprint $table) {
            $table->id();
            $table->integer('section_question_id')->nullable();
             $table->text('condition_value')->nullable();
            $table->text('dependent_question')->nullable();
            $table->integer('required')->default(1)->comment('1 = yes, 0 = no');
            $table->integer('ordering')->nullable();
            $table->unsignedTinyInteger('status')->default(1)->comment('Status: 1 = active, 0 = inactive');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('section_dependent_questions');
    }
};
