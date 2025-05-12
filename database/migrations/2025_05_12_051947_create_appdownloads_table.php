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
        Schema::create('appdownloads', function (Blueprint $table) {
            $table->id('appID'); 
            $table->string('referralCode', 10)->nullable();
            $table->string('ipAddress', 50)->nullable();
            $table->string('referer', 200)->nullable();
            $table->dateTime('dateTime')->nullable();
            $table->tinyInteger('status')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('appdownloads');
    }
};
