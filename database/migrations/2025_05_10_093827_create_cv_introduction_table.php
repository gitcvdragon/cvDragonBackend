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
        Schema::create('cv-introduction', function (Blueprint $table) {
            $table->bigIncrements('id'); // ID column (primary key)
            $table->bigInteger('introid')->unsigned(); // introid column
            $table->text('introduction'); // introduction column
            $table->string('title', 255); // title column
            $table->timestamp('created')->useCurrent()->useCurrentOnUpdate(); // created column (with current timestamp)
            $table->tinyInteger('proofRead'); // proofRead column (tinyint)
            $table->date('proofReadDate'); // proofReadDate column (date)
            $table->smallInteger('status')->default(0); // status column (smallint)
            $table->bigInteger('refID'); // refID column (bigint)
            $table->timestamps(); // created_at and updated_at (timestamps)
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cv-introduction');
    }
};
