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
        Schema::create('resource-links', function (Blueprint $table) {
            $table->id(); // equivalent to $table->bigIncrements('id')
            $table->integer('linkOrder');
            $table->string('linkHeading', 200);
            $table->string('linkDetails', 200);
            $table->tinyInteger('status');
            $table->timestamps(); // Optional: adds created_at and updated_at
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('resource-links');
    }
};
