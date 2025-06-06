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
        Schema::create('resource-profilefont', function (Blueprint $table) {
            $table->increments('fontid');
            $table->string('fontTypeName', 100)->collation('utf8mb4_unicode_ci');
            $table->string('fontType', 200)->collation('utf8mb4_unicode_ci');
            $table->string('googleFontName', 255)->collation('utf8mb4_unicode_ci');
            $table->integer('fontSize');
            $table->text('appliedOn')->collation('utf8mb4_unicode_ci');
            $table->integer('downloadTime');
            $table->tinyInteger('web');
            $table->tinyInteger('app');
           $table->unsignedTinyInteger('status')->default(1)->comment('Status: 1 = active, 0 = inactive');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('resource-profilefont');
    }
};
