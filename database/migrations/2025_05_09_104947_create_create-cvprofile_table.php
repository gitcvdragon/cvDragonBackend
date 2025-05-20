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
        Schema::create('create-cvprofile', function (Blueprint $table) {
            $table->bigIncrements('cvid');
            $table->bigInteger('id'); 
            $table->string('profileName', 100);
            $table->string('sections', 255);
            $table->string('sectionOrder', 255);
            $table->integer('design');
            $table->integer('font');
            $table->integer('setting');
            $table->string('profilePicture', 100);
            $table->bigInteger('intro');
            $table->tinyInteger('isPublic');
            $table->tinyInteger('progressReport');
            $table->timestamp('dateUpdated')->useCurrent()->useCurrentOnUpdate();
            $table->smallInteger('status')->default(1)->comment('1=active, 0=inactive');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('create-cvprofile');
    }
};
