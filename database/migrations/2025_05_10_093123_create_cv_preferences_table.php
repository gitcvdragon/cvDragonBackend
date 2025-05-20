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
        Schema::create('cv-preference', function (Blueprint $table) {
            $table->increments('prefid');
            $table->bigInteger('id');
            $table->tinyInteger('passport')->nullable();
            $table->string('passportDetails', 100)->nullable();
            $table->tinyInteger('recommendations')->nullable();
            $table->string('preferredLocation', 50)->nullable();
            $table->tinyInteger('canRelocate')->nullable();
            $table->string('noticePeriod', 20)->nullable();
            $table->tinyInteger('canJoin')->nullable();
            $table->string('expectedCTC', 100)->nullable();
            $table->tinyInteger('isNegotiate')->nullable();
            $table->tinyInteger('declaration')->nullable();
            $table->string('signature', 200)->nullable();
            $table->timestamp('created')->useCurrent()->useCurrentOnUpdate();
            $table->tinyInteger('status')->nullable();
        });

    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cv-preference');
    }
};
