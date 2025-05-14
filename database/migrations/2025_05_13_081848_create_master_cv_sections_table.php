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
        Schema::create('master_cv_sections', function (Blueprint $table) {
            $table->id();
            $table->string('heading')->nullable();
            $table->text('description')->nullable();
            $table->string('icon')->nullable();
            $table->string('color')->nullable();
            $table->integer('ordering')->nullable();
            $table->unsignedTinyInteger('status')->default(1)->comment('Status: 1 = active, 0 = inactive');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('master_cv_sections');
    }
};
