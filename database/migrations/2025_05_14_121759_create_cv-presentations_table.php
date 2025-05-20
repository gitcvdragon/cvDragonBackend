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
        Schema::create('cv-presentations', function (Blueprint $table) {
             $table->increments('activityid'); 
            $table->bigInteger('id');
            $table->smallInteger('status')->default(1)->comment('0=inactive, 1=active'); 
            $table->string('title', 200)->collation('latin1_swedish_ci');
            $table->text('description')->collation('latin1_swedish_ci');
            $table->index('id');
            $table->timestamps('created');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cv-presentations');
    }
};
