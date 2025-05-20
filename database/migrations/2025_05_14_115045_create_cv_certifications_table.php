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
        Schema::create('cv-certification', function (Blueprint $table) {
            $table->increments('certificateid');
            $table->bigInteger('id');
            $table->string('certificate', 250)->collation('latin1_swedish_ci'); // composite primary
            $table->string('authority', 150)->collation('latin1_swedish_ci'); // composite primary
            $table->year('year'); // composite primary
            $table->tinyInteger('status');
            // Indexes and Keys
            $table->index('id');
            $table->timestamp('created')->useCurrent();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cv-certification');
    }
};
