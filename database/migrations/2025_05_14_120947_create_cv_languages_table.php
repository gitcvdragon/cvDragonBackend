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
        Schema::create('cv-languages', function (Blueprint $table) {
            $table->id(); // Auto-increment id
            $table->unsignedBigInteger('refID');
            $table->unsignedBigInteger('user_id');
            $table->string('language', 50)->collation('latin1_swedish_ci');
            $table->tinyInteger('readLanguage');
            $table->tinyInteger('writeLanguage');
            $table->tinyInteger('speakLanguage');
            $table->tinyInteger('status');

            $table->index('id');
            $table->unique(['refID', 'user_id', 'language', 'status'], 'unique_language_per_user');
        
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cv-languages');
    }
};
