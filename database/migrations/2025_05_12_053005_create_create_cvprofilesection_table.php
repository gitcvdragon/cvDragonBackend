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
        Schema::create('profile_sections', function (Blueprint $table) {
            $table->increments('psid'); // Primary key, auto-increment
            $table->integer('cvid')->index(); // Foreign key to cvprofiles.cvid
            $table->unsignedBigInteger('id'); // Possibly user ID
            $table->integer('section')->index();
            $table->text('subsection');
            $table->string('showName')->collation('utf8mb4_unicode_ci');
            $table->timestamp('dateCreated')->useCurrent()->useCurrentOnUpdate();
            $table->tinyInteger('status')->index();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('create_cvprofilesection');
    }
};
