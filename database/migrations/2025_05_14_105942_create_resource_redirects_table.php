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
        Schema::create('resource-redirect', function (Blueprint $table) {
            $table->id();
            $table->string('redirectDisplayIndex', 100); // fixed name to be a valid column name
            $table->string('redirectHeading', 200);
            $table->string('redirectDescription', 200);
            $table->string('redirectLink', 200);
            $table->string('redirectImage', 200);
            $table->tinyInteger('status');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('resource-redirect');
    }
};
