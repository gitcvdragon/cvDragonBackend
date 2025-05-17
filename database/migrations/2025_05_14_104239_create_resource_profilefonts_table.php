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
            $table->id();
            $table->string('fontTypeName', 100);
            $table->string('fontType', 200);
            $table->string('googleFontName', 255);
            $table->integer('fontSize');
            $table->text('appliedOn');
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
