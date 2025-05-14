<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('cv-association', function (Blueprint $table) {
            $table->id(); // AUTO_INCREMENT id
            $table->unsignedBigInteger('user_id'); // Primary (composite)
            $table->string('organization', 100)->collation('utf8_unicode_ci'); // Primary
            $table->string('position', 50)->collation('utf8_unicode_ci'); // Primary
            $table->string('location', 50)->collation('utf8_unicode_ci');
            $table->mediumText('description')->collation('utf8_unicode_ci');
            $table->date('dateJoining');
            $table->date('dateLeaving')->nullable();
            $table->tinyInteger('present'); // 1 = currently working
            $table->tinyInteger('status');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cv-association');
    }
};
