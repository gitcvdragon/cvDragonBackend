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
            $table->increments('documentID');
            $table->string('documentTitle', 255)->collation('utf8mb4_bin');
            $table->string('documentLocation', 255)->collation('utf8_general_ci');
            $table->integer('documentSection');
            $table->string('documentSubSection', 20)->collation('utf8_general_ci');
            $table->bigInteger('id');
            $table->dateTime('date');
            $table->tinyInteger('status');
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
