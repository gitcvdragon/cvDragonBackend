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
        Schema::create('create-cvprofilesection', function (Blueprint $table) {
            $table->id('psid'); 
            $table->integer('cvid')->nullable();
            $table->integer('id')->nullable();
            $table->string('section')->nullable();
            $table->string('subsection')->nullable();
            $table->string('showName')->nullable();
            $table->timestamp('dateCreated')->useCurrent()->useCurrentOnUpdate();
            $table->unsignedTinyInteger('status')->default(1)->comment('Status: 1 = active, 0 = inactive');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('master_cv_sections');
    }
};
