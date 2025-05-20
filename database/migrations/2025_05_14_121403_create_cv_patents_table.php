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
        Schema::create('cv-patent', function (Blueprint $table) {
           $table->increments('patentid'); // id INT AUTO_INCREMENT
            $table->bigInteger('id');
            $table->string('title', 200)->collation('latin1_swedish_ci');
            $table->string('patentOffice', 200)->collation('latin1_swedish_ci');
            $table->string('patentStatus', 10)->collation('latin1_swedish_ci');
            $table->string('patentApplication', 100)->collation('latin1_swedish_ci');
            $table->string('patentDate', 10)->collation('latin1_swedish_ci');
            $table->text('description')->collation('latin1_swedish_ci');
            $table->timestamp('created')->useCurrent()->useCurrentOnUpdate();
            $table->tinyInteger('status');

            $table->index('id');     
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cv-patent');
    }
};
