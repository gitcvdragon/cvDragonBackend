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
        Schema::create('help-faq', function (Blueprint $table) {
            $table->increments('faqID');
            $table->string('faq', 250)->collation('utf8mb4_bin');
            $table->text('answer')->collation('utf8mb4_bin');
            $table->integer('app');
            $table->integer('web');
            $table->tinyInteger('status')->default(1)->comment('1=active, 0=inactive');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('help-faq');
    }
};
