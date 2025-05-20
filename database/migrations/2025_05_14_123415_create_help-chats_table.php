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
            $table->increments('chatID');
            $table->unsignedBigInteger('senderID');
            $table->unsignedBigInteger('receiverID');
            $table->text('chat')->collation('utf8mb4_bin');
            $table->integer('type');
            $table->tinyInteger('isResolved');
            $table->dateTime('dateCreated');
            $table->timestamp('dateUpdated')->useCurrent()->useCurrentOnUpdate();
            $table->unsignedBigInteger('adminID');
            $table->tinyInteger('status');

            $table->index(['senderID', 'receiverID']);
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
