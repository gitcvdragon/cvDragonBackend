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
        Schema::create('cvprofiles', function (Blueprint $table) {
            $table->id(); // Auto-increment primary key
            $table->unsignedBigInteger('user_id');
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
            $table->string('profileName', 100); // Profile name
            $table->string('sections', 255); // Sections
            $table->string('sectionOrder', 255); // Section order
            $table->integer('design'); // Design field
            $table->integer('font'); // Font field
            $table->integer('setting'); // Setting field
            $table->string('profilePicture', 100); // Profile picture
            $table->bigInteger('intro'); // Intro field
            $table->tinyInteger('isPublic'); // Public status
            $table->tinyInteger('progressReport'); // Progress report
            $table->smallInteger('status'); // Status field });
             $table->softDeletes(); // adds deleted_at column
            $table->timestamps(); 
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cvprofiles');
    }
};
