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
        Schema::create('help-chat', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('senderID');
            $table->unsignedBigInteger('receiverID');
            $table->text('chat')->collation('utf8mb4_bin');
            $table->integer('type');
            $table->tinyInteger('isResolved');
            $table->unsignedBigInteger('adminID');
            $table->tinyInteger('status');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('help_chats');
    }
};
