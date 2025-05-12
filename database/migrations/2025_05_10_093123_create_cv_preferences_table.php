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
        Schema::create('cv_preferences', function (Blueprint $table) {
            $table->increments('prefid');
            $table->bigInteger('id');
            $table->tinyInteger('passport')->nullable();
            $table->string('passportDetails', 100);
            $table->tinyInteger('recommendations')->nullable();
            $table->string('preferredLocation', 50);
            $table->tinyInteger('canRelocate');
            $table->string('noticePeriod', 20);
            $table->tinyInteger('canJoin');
            $table->string('expectedCTC', 100);
            $table->tinyInteger('isNegotiate');
            $table->tinyInteger('declaration')->nullable();
            $table->string('signature', 200);
            $table->timestamp('created')->useCurrent()->useCurrentOnUpdate();
            $table->tinyInteger('proofRead');
            $table->date('proofReadDate');
            $table->tinyInteger('status');
            $table->bigInteger('refID');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cv_preferences');
    }
};
