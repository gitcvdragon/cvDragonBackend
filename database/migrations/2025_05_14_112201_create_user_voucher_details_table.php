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
        Schema::create('user_voucher_details', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id');
            $table->string('userName', 200)->charset('latin1')->collation('latin1_swedish_ci');
            $table->string('userEmail', 200)->charset('latin1')->collation('latin1_swedish_ci');
            $table->string('userPhone', 20)->charset('latin1')->collation('latin1_swedish_ci');
            $table->string('userInstitute', 200)->charset('latin1')->collation('latin1_swedish_ci');
            $table->integer('userInstituteID');
            $table->string('userLocation', 50)->charset('latin1')->collation('latin1_swedish_ci');
            $table->string('userEducation', 50)->charset('latin1')->collation('latin1_swedish_ci');
            $table->integer('userPassYear');
            $table->integer('voucherSN');
            $table->string('voucherCode', 19)->charset('latin1')->collation('latin1_swedish_ci');
            $table->integer('voucherDesign');
            $table->integer('voucherDuration');
            $table->tinyInteger('notify');
            $table->string('notifyDetails', 200)->charset('latin1')->collation('latin1_swedish_ci');
            $table->tinyInteger('status');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('user_voucher_details');
    }
};
