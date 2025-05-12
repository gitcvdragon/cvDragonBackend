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
        Schema::create('cv-basic-info', function (Blueprint $table) {
            $table->id(); // id bigint primary key
            $table->string('cvFullName', 100)->collation('utf8mb4_bin');
            $table->tinyInteger('verified')->nullable();
            $table->string('nationality', 50)->collation('utf8_unicode_ci')->nullable();;
            $table->string('gender', 50)->collation('utf8_unicode_ci')->nullable();;
            $table->date('dateBirth')->nullable();
            $table->string('maritalStatus', 20)->collation('utf8_unicode_ci')->nullable();;
            $table->string('facebookLink', 200)->collation('utf8_unicode_ci')->nullable();;
            $table->string('linkedinLink', 200)->collation('utf8_unicode_ci')->nullable();;
            $table->string('twitterLink', 200)->collation('utf8_unicode_ci')->nullable();;
            $table->string('blogLink', 200)->collation('utf8_unicode_ci')->nullable();;
            $table->timestamp('dateCreated')->useCurrent()->useCurrentOnUpdate();
            $table->tinyInteger('proofRead')->nullable();;
            $table->date('proofReadDate')->nullable();;
            $table->smallInteger('status');
            $table->bigInteger('refID')->nullable();;
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cv-basic-info');
    }
};
