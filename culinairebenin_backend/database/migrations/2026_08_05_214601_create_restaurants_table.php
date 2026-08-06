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
        Schema::create('restaurants', function (Blueprint $table) {
            $table->id();
            $table->foreignId('proprietaire_id')->constrained('utilisateurs')->onDelete('cascade');
            $table->foreignId('region_id')->constrained('regions')->onDelete('cascade');
            $table->string('nom');
            $table->text('description')->nullable();
            $table->string('adresse');
            $table->string('ville');
            $table->float('latitude');
            $table->float('longitude');
            $table->string('telephone');
            $table->string('email')->nullable();
            $table->string('photo')->nullable();
            $table->string('horaires')->nullable();
            $table->boolean('est_ouvert')->default(false);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('restaurants');
    }
};
