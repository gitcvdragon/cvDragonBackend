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
        Schema::create('user_feedback', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id');
        $table->string('userName', 100)->charset('utf8mb4')->collation('utf8mb4_unicode_ci');
        $table->string('userPhone', 20)->charset('utf8mb4')->collation('utf8mb4_unicode_ci');
        $table->string('userEmail', 50)->charset('utf8mb4')->collation('utf8mb4_unicode_ci');
        $table->text('feedback')->charset('utf8mb4')->collation('utf8mb4_unicode_ci');
        $table->integer('rating');
        $table->tinyInteger('isResolved');
        $table->dateTime('dateResolved');
        $table->timestamp('dateCreated')->useCurrent();
        $table->string('mode', 10)->charset('utf8mb4')->collation('utf8mb4_unicode_ci');
        $table->tinyInteger('status');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('user_feedback');
    }
};
