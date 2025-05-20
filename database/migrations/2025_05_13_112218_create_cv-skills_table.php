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
        Schema::create('cv-skills', function (Blueprint $table) {
            $table->increments('skillid'); // Auto-incrementing primary key
            $table->bigInteger('id');
            $table->string('skill', 100)->nullable(); // Skill name column (varchar(100))
            $table->text('description')->nullable(); // Description column (text)
            $table->tinyInteger('status')->default(1)->comment('1 = active, 0 = inactive'); 
            $table->index('skillid');
            $table->timestamps('created');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cv-skills');
    }
};
