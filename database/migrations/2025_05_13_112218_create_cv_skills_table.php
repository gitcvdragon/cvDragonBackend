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
        Schema::create('cv-skills', function (Blueprint $table) {
            $table->bigIncrements('skillid'); // Auto-incrementing primary key
            $table->string('skill', 100)->nullable(); // Skill name column (varchar(100))
            $table->text('description')->nullable(); // Description column (text)
            $table->timestamp('created')->useCurrent()->useCurrentOnUpdate(); // Created timestamp column
            $table->tinyInteger('proofRead')->default(0); // proofRead column (tinyint(4)) with a default of 0
            $table->date('proofReadDate'); // proofReadDate column (date)
            $table->integer('masterID')->default(0); // masterID column (int(11)) with a default value of 0
            $table->tinyInteger('status')->default(1); // status column (tinyint(1)) with a default of 1
            $table->bigInteger('refID')->nullable(); // refID column (bigint(20))

            // Adding index on 'skillid'
            $table->index('skillid');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cv-skills');
    }
};
