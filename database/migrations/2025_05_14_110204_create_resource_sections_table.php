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
        Schema::create('resource-section', function (Blueprint $table) {
            $table->id();
            $table->unsignedInteger('master_cv_sections_id');
            $table->tinyInteger('main');
            $table->unsignedInteger('orderSection');
            $table->tinyInteger('defaultSection')->default(1)->comment('1 = Default, 0 = Custom');
            $table->text('sectionContent')->nullable();
            $table->text('sectionContentApp')->nullable();
            $table->text('sectionInfoApp')->nullable();
            $table->text('sectionDefaultContent')->nullable();
            $table->string('sectionName', 50)->charset('utf8mb4')->collation('utf8mb4_bin');
            $table->string('sectionLink', 100)->charset('latin1')->collation('latin1_swedish_ci');
            $table->string('sectionTable', 20)->charset('latin1')->collation('latin1_swedish_ci');
            $table->string('idColumnName', 225)->charset('latin1')->collation('latin1_swedish_ci');
            $table->smallInteger('status')->default(1)->comment('1 = Active, 0 = Inactive');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('resource-section');
    }
};
