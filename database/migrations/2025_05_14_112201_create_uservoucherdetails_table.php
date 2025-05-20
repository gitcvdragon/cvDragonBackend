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
        Schema::create('uservoucherdetails', function (Blueprint $table) {
            $table->increments('sn');
            $table->bigInteger('id');
            $table->string('userName', 200)->collation('latin1_swedish_ci');
            $table->string('userEmail', 200)->collation('latin1_swedish_ci');
            $table->string('userPhone', 20)->collation('latin1_swedish_ci');
            $table->string('userInstitute', 200)->collation('latin1_swedish_ci');
            $table->integer('userInstituteID');
            $table->string('userLocation', 50)->collation('latin1_swedish_ci');
            $table->string('userEducation', 50)->collation('latin1_swedish_ci');
            $table->integer('userPassYear');
            $table->integer('voucherSN')->index();
            $table->string('voucherCode', 19)->collation('latin1_swedish_ci')->index();
            $table->integer('voucherDesign');
            $table->integer('voucherDuration');
            $table->tinyInteger('notify');
            $table->string('notifyDetails', 200)->collation('latin1_swedish_ci');
            $table->tinyInteger('status');
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
