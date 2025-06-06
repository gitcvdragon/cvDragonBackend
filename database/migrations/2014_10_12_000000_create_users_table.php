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
        Schema::create('users', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->integer('categoryid')->nullable()->comment('0 - Guest, 1 - Free, 2 - Premium, 3 - Pro, 4 - Lifetime Access, 5 - Student, 10 - Admin');
            $table->bigInteger('referenceID')->nullable();
            $table->string('socialType', 100)->nullable();
            $table->string('socialid', 100)->nullable();
            $table->string('authKey')->nullable();
            $table->string('socialToken', 800)->nullable();
            $table->string('username', 100)->nullable();
            $table->string('gender', 10)->nullable();
            $table->string('usermobile', 20)->nullable();
            $table->string('userEmail', 100)->nullable();
            $table->string('userPassword', 100)->nullable();
            $table->string('playerID', 50)->nullable();
            $table->string('playerIDMore', 100)->nullable();
            $table->tinyInteger('mobilePlatform')->nullable();
            $table->integer('appVersion')->nullable();
            $table->tinyInteger('webLoginFlag')->nullable();
            $table->dateTime('webLogin')->nullable();
            $table->dateTime('appLogin')->nullable();
            $table->tinyInteger('openCount')->nullable();
            $table->timestamp('dateUpdated')->useCurrent()->nullable();
            $table->smallInteger('status')->comment('0 = inactive, 1 = active')->default(1);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('users');
    }
};
