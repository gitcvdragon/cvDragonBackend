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
        Schema::create('cv-technical', function (Blueprint $table) {
            $table->increments('technicalid');
            $table->bigInteger('id');
            $table->string('technical', 250)->collation('latin1_swedish_ci');
            $table->string('level', 250);
            $table->tinyInteger('status')->default(1)->comment('1 = active, 0 = inactive'); 
            $table->timestamps('created');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cv-technical');
    }
};
