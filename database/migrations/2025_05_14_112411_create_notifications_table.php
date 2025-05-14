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
        Schema::create('notifications', function (Blueprint $table) {
            $table->id();
             $table->string('heading', 200)->collation('utf8mb4_unicode_ci');
        $table->text('description')->collation('utf8mb4_unicode_ci');
        $table->string('displayImage', 150)->collation('utf8mb4_unicode_ci');
        $table->string('insideImage', 100)->collation('utf8mb4_unicode_ci');
        $table->string('showNote', 250)->collation('utf8mb4_unicode_ci');
        $table->string('thankNote', 150)->collation('utf8mb4_unicode_ci');
        $table->string('type', 20)->collation('utf8mb4_unicode_ci');
        $table->string('link', 100)->collation('utf8mb4_unicode_ci');
        $table->string('linkHeading', 100)->collation('utf8mb4_unicode_ci');
        $table->tinyInteger('formDisplay');
        $table->string('notificationCategory', 50)->collation('utf8mb4_unicode_ci');
        $table->string('version', 50)->collation('utf8mb4_unicode_ci');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('notifications');
    }
};
