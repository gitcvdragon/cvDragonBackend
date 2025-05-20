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
        Schema::create('resource_profile_colors', function (Blueprint $table) {
            $table->increments('settingid');
            $table->string('name', 100)->collation('utf8mb4_unicode_ci');
            $table->text('content')->collation('utf8mb4_unicode_ci');
            $table->string('heading', 10)->collation('utf8mb4_unicode_ci');
            $table->string('color1', 10)->nullable()->collation('utf8mb4_unicode_ci');
            $table->string('color2', 10)->nullable()->collation('utf8mb4_unicode_ci');
            $table->string('color3', 10)->nullable()->collation('utf8mb4_unicode_ci');
            $table->string('color4', 10)->nullable()->collation('utf8mb4_unicode_ci');
            $table->integer('downloadTimes');
            $table->index('name');
            $table->smallInteger('status')->default(1)->comment('1 = Active, 0 = Inactive');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('resource_profile_colors');
    }
};
