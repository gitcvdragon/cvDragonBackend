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
        Schema::create('cvdragonappconfignew', function (Blueprint $table) {
            $table->increments('configid'); // Primary key with auto-increment
            $table->string('configkey', 100)->collation('utf8_general_ci')->nullable();
            $table->string('changesBeforeUpdate', 255)->collation('utf8_general_ci')->nullable();
            $table->integer('version')->nullable();
            $table->tinyInteger('configvalue')->nullable();
            $table->tinyInteger('configvalueios')->nullable();
            $table->text('parameter')->collation('utf8mb4_bin')->nullable();
            $table->tinyInteger('sendData')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cvdragonappconfignew');
    }
};
