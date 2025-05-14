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
        Schema::create('user-documents', function (Blueprint $table) {
            $table->id();
            $table->string('documentTitle', 255)->charset('utf8mb4')->collation('utf8mb4_bin');
            $table->string('documentLocation', 255)->charset('utf8')->collation('utf8_general_ci');
            $table->unsignedInteger('documentSection');
            $table->string('documentSubSection', 20)->charset('utf8')->collation('utf8_general_ci');
            $table->unsignedBigInteger('user_id');
            $table->dateTime('date');
            $table->tinyInteger('status');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('user-documents');
    }
};
