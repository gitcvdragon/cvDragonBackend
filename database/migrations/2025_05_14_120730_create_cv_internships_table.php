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
        Schema::create('cv-internship', function (Blueprint $table) {
            $table->increments('interestid');
            $table->bigInteger('id');
            $table->string('organization', 50)->collation('latin1_swedish_ci');
            $table->string('title', 250)->collation('latin1_swedish_ci');
            $table->string('designation', 50)->collation('latin1_swedish_ci');
            $table->string('duration', 50)->collation('latin1_swedish_ci');
            $table->string('location', 50)->collation('latin1_swedish_ci');
            $table->text('description')->collation('latin1_swedish_ci');
            $table->smallInteger('status')->default(1)->comment('0=inactive, 1=active'); 
            $table->index('id');
            $table->timestamps('created');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cv-internship');
    }
};
