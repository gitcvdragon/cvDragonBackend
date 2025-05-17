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
        Schema::create('resource-profiledesign', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('resource_profile_design_categorie_id');
            $table->foreign('resource_profile_design_categorie_id', 'rpd_category_fk')->references('id')->on('resource_profile_design_categories')->onDelete('cascade');
            $table->string('designName', 100);
            $table->text('content');
            $table->integer('designPrice');
            $table->tinyInteger('format')->default(1);
            $table->tinyInteger('isPrivate');
            $table->string('sections', 255);
            $table->string('version', 10); // You may want to store this as JSON if it's [6,7]
            $table->string('sectionOrder', 255);
            $table->string('sectionDefault', 255);
            $table->tinyInteger('sectionColumn');
            $table->tinyInteger('isDownload');
            $table->string('author', 100);
            $table->float('rating');
            $table->integer('downloadTimes');
            $table->tinyInteger('web');
            $table->tinyInteger('app');
            $table->string('heading', 10);
            $table->string('color1', 10);
            $table->string('color2', 10);
            $table->string('color3', 10);
            $table->string('color4', 10);
            $table->float('basevalue');
            $table->float('headText');
            $table->float('timeLine');
            $table->float('timeLineSmall');
            $table->float('timeSubLine');
            $table->float('headLine');
            $table->float('subLine');
            $table->float('baseLine');
            $table->float('introLine');
            $table->float('nameLine');
            $table->float('nameHeight');
            $table->float('introHeight');
            $table->float('headLineHeight');
            $table->float('headerLineHeight');
            $table->float('GenLine');
            $table->string('logo', 30);
            $table->string('template', 255);
            $table->tinyInteger('status')->default(1)->comment('1=active, 0=inactive');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('resource-profiledesign');
    }
};
