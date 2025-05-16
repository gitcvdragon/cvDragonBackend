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
        Schema::create('create-cvprofile', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id');
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
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
            $table->tinyInteger('status')->default(1)->comment('1=active,0=inactive');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('create-cvprofile');
    }
};
