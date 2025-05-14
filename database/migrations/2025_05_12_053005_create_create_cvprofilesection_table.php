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
        Schema::create('create-cvprofilesection', function (Blueprint $table) {
            $table->id()->unsigned(); // Primary key as unsigned bigint
            $table->integer('cvid')->nullable(); // Foreign key to CV table
            $table->integer('user_id')->nullable(); // Foreign key to user table
            $table->string('section', 255)->collation('utf8mb4_unicode_ci')->nullable();
            $table->string('subsection', 255)->collation('utf8mb4_unicode_ci')->nullable();
            $table->string('showName', 255)->collation('utf8mb4_unicode_ci')->nullable();
            $table->tinyInteger('status')->nullable(); // Status field
            $table->timestamps(); // Automatically create created_at and updated_at
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('create-cvprofilesection');
    }
};
