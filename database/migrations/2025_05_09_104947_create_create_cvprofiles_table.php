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
        Schema::create('create_cvprofile', function (Blueprint $table) {
            $table->unsignedBigInteger('cvid')->primary();
            $table->unsignedBigInteger('id');
            $table->string('profileName', 100)->nullable();
            $table->string('sections', 255)->nullable();
            $table->string('sectionOrder', 255)->nullable();
            $table->integer('design')->nullable();
            $table->integer('font')->nullable();
            $table->integer('setting')->nullable();
            $table->string('profilePicture', 100)->nullable();
            $table->unsignedBigInteger('intro')->nullable();
            $table->tinyInteger('isPublic')->default(0);
            $table->tinyInteger('progressReport')->default(0);
            $table->timestamp('dateUpdated')->useCurrent()->nullable();
            $table->smallInteger('status')->default(1);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('create_cvprofile');
    }
};
