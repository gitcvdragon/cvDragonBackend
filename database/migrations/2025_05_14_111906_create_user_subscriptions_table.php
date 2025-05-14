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
        Schema::create('user-subscription', function (Blueprint $table) {
            $table->id();
             $table->unsignedBigInteger('user_id');
        $table->integer('design');
        $table->date('activate');
        $table->date('expiry');
        $table->string('securityKey', 19)->charset('utf8mb4')->collation('utf8mb4_unicode_ci');
        $table->date('dateCreated');
        $table->timestamp('dateUpdated')->useCurrent();
        $table->tinyInteger('status');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('user-subscription');
    }
};
