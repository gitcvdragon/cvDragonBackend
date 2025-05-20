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
        Schema::create('help-videos', function (Blueprint $table) {
           $table->increments('videoID');
            $table->string('heading', 200)->collation('utf8mb4_bin');
            $table->string('link', 200)->collation('latin1_swedish_ci');
            $table->timestamp('dateCreated')->useCurrent()->useCurrentOnUpdate();
            $table->tinyInteger('web');
            $table->tinyInteger('app');
            $table->tinyInteger('status')->default(1)->comment('1=active, 0=inactive');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('help-videos');
    }
};
