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
        Schema::create('cv-publications', function (Blueprint $table) {
            $table->increments('publishid');
            $table->bigInteger('id');
            $table->string('title', 200)->collation('latin1_swedish_ci');
            $table->string('category', 100)->collation('latin1_swedish_ci');
            $table->string('publisher', 200)->collation('latin1_swedish_ci');
            $table->string('publishDate', 10)->collation('latin1_swedish_ci');
            $table->text('description')->collation('latin1_swedish_ci');
            $table->smallInteger('status')->default(1)->comment('0=inactive, 1=active');
            $table->timestamps('created');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cv-publications');
    }
};
