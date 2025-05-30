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
        Schema::create('cv-languages', function (Blueprint $table) {
            $table->increments('langid');
            $table->bigInteger('refID');
            $table->bigInteger('id');
            $table->string('language', 50)->collation('latin1_swedish_ci');
            $table->tinyInteger('readLanguage');
            $table->tinyInteger('writeLanguage');
            $table->tinyInteger('speakLanguage');
           $table->tinyInteger('status')->default(1)->comment('1 = active, 0 = inactive'); 

            $table->index('id');
            $table->timestamps('created');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cv-languages');
    }
};
