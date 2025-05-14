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
        Schema::create('cvsections', function (Blueprint $table) {
            $table->id('id');  // BigInt Primary key
            $table->integer('section')->index();  // Index for section
            $table->integer('sectionid')->index();  // Index for sectionid
            $table->integer('contentAdded', false, true)->length(6);
            $table->integer('contentStatus');
            $table->timestamp('dateCreated')->useCurrent()->useCurrentOnUpdate();
            $table->smallInteger('status');
            $table->timestamps();  // created_at and updated_at fields
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cvsections');
    }
};
