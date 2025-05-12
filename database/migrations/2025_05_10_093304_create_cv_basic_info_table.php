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
        Schema::create('cv_basic_info', function (Blueprint $table) {
            $table->id(); // id bigint primary key
            $table->string('cvFullName', 100)->collation('utf8mb4_bin');
            $table->tinyInteger('verified');
            $table->string('nationality', 50)->collation('utf8_unicode_ci');
            $table->string('gender', 50)->collation('utf8_unicode_ci');
            $table->date('dateBirth')->nullable();
            $table->string('maritalStatus', 20)->collation('utf8_unicode_ci');
            $table->string('facebookLink', 200)->collation('utf8_unicode_ci');
            $table->string('linkedinLink', 200)->collation('utf8_unicode_ci');
            $table->string('twitterLink', 200)->collation('utf8_unicode_ci');
            $table->string('blogLink', 200)->collation('utf8_unicode_ci');
            $table->timestamp('dateCreated')->useCurrent()->useCurrentOnUpdate();
            $table->tinyInteger('proofRead');
            $table->date('proofReadDate');
            $table->smallInteger('status');
            $table->bigInteger('refID');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cv_basic_info');
    }
};
