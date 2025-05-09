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
        Schema::create('admin_sql_queries', function (Blueprint $table) {
            $table->increments('sqlid');
            $table->string('type', 10);
            $table->string('title', 255);
            $table->string('description', 255);
            $table->string('sqlTable', 255);
            $table->string('sqlType', 10);
            $table->string('parameter', 255);
            $table->text('parameterType');
            $table->integer('displayType');
            $table->text('access');
            $table->tinyInteger('status');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('admin_sql_queries');
    }
};
