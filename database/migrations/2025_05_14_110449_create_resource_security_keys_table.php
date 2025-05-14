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
        Schema::create('resource-securityKeys', function (Blueprint $table) {
            $table->id(); // secureID Index (Primary Key)
            $table->unsignedInteger('assign_id');
            $table->string('assign_to', 150)->charset('latin1')->collation('latin1_swedish_ci');
            $table->unsignedBigInteger('security_voucher');
            $table->string('security_key', 19)->charset('latin1')->collation('latin1_swedish_ci');
            $table->unsignedInteger('design_id');
            $table->unsignedInteger('time_period');
            $table->text('message')->charset('latin1')->collation('latin1_swedish_ci');
            $table->unsignedBigInteger('original_id'); // renamed to avoid id conflict
            $table->string('note', 250)->charset('latin1')->collation('latin1_swedish_ci');
            $table->tinyInteger('status');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('resource-securityKeys');
    }
};
