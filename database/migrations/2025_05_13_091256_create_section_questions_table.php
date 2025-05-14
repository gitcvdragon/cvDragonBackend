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
        Schema::create('section_questions', function (Blueprint $table) {
            $table->id();
            $table->integer('resource_section_id')->nullable();
            $table->text('question')->nullable();
            $table->enum('question_type', ['text', 'select', 'radio', 'checkbox', 'date']);
            $table->integer('is_dependent')->default(0)->comment('1 = yes, 0 = no');
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
        Schema::dropIfExists('section_questions');
    }
};
