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
         Schema::create('create-cvprofilesection', function (Blueprint $table) {
            $table->id('psid'); // Primary Index
            $table->integer('cvid');
            $table->bigInteger('id');
            $table->integer('section');
            $table->text('subsection');
            $table->string('showName', 255);
            $table->timestamp('dateCreated');
            $table->tinyInteger('status')->default(1)->comment('1=active, 0=inactive');
                        
            $table->index('cvid');
            $table->index('section');
            $table->index('status');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('create-cvprofilesection');
    }
};
