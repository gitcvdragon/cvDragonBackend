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
            $table->bigIncrements('cvid'); // Auto-increment primary key
            $table->bigInteger('id'); // Regular field
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
            $table->timestamp('dateUpdated')->useCurrent()->nullable(); // Date updated
            $table->smallInteger('status'); // Status field });
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
