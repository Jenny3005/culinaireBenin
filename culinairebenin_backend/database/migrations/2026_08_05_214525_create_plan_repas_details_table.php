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
        Schema::create('plan_repas_details', function (Blueprint $table) {
            $table->id();
            $table->foreignId('plan_repas_id')->constrained('plan_repas')->onDelete('cascade');
            $table->foreignId('recette_id')->constrained('recettes')->onDelete('cascade');
            $table->enum('jour_semaine', ['lundi', 'mardi', 'mercredi', 'jeudi', 'vendredi', 'samedi', 'dimanche']);
            $table->enum('moment_journee', ['matin', 'midi', 'soir']);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('plan_repas_details');
    }
};
