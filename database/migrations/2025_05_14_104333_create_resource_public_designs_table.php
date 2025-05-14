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
        Schema::create('resource-publicDesign', function (Blueprint $table) {
            $table->id();
            $table->integer('isPublic');
            $table->string('publicDesignName', 100);
            $table->text('publicDesignDetails');
            $table->tinyInteger('status');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('resource-publicDesign');
    }
};
