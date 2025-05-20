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
        Schema::create('cv-contact', function (Blueprint $table) {
           $table->bigInteger('id');
            $table->string('phoneNumber', 50)->nullable();
            $table->string('emailAddress', 50);
            $table->string('location', 50);
            $table->text('fullAddress');
            $table->timestamp('created')->useCurrent()->useCurrentOnUpdate();
           $table->tinyInteger('status')->default(1)->comment('1=active, 0=inactive');
        });

    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cv-contact');
    }
};
