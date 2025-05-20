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
        Schema::create('user-feedback', function (Blueprint $table) {
            $table->increments('feedbackid');
            $table->bigInteger('id');
            $table->string('userName', 100)->collation('utf8mb4_unicode_ci');
            $table->string('userPhone', 20)->collation('utf8mb4_unicode_ci');
            $table->string('userEmail', 50)->collation('utf8mb4_unicode_ci');
            $table->text('feedback')->collation('utf8mb4_unicode_ci');
            $table->integer('rating');
            $table->tinyInteger('isResolved');
            $table->dateTime('dateResolved');
            $table->timestamp('dateCreated')->useCurrent();
            $table->string('mode', 10)->collation('utf8mb4_unicode_ci');
            $table->tinyInteger('status');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('user-feedback');
    }
};
