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
        Schema::create('cv-academic-projects', function (Blueprint $table) {
             $table->increments('academicid');
            $table->bigInteger('id');
            $table->string('title', 100)->collation('latin1_swedish_ci');
            $table->text('description')->collation('latin1_swedish_ci');
            $table->smallInteger('status')->default(1)->comment('0=inactive, 1=active'); 
            $table->timestamp('created')->useCurrent()->useCurrentOnUpdate();
            $table->unique(['user_id', 'title', 'status']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cv-academic-projects');
    }
};
