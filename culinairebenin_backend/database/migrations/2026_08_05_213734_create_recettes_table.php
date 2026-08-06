

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
        Schema::create('recettes', function (Blueprint $table) {
            $table->id();
            $table->string('nom');
            $table->text('description')->nullable();
            $table->foreignId('categorie_id')->constrained('categories')->onDelete('cascade');
            $table->foreignId('region_id')->constrained('regions')->onDelete('cascade');
            $table->foreignId('ethnie_id')->constrained('ethnies')->onDelete('cascade');
            $table->foreignId('occasion_id')->constrained('occasions')->onDelete('cascade');
            $table->foreignId('auteur_id')->constrained('utilisateurs')->onDelete('cascade');
            $table->integer('temps_preparation')->nullable();
            $table->integer('temps_cuisson')->nullable();
            $table->enum('difficulte', ['facile', 'moyen', 'difficile'])->nullable();
            $table->text('histoire_culturelle')->nullable();
            $table->float('valeur_calorique')->nullable();
            $table->enum('statut', ['brouillon', 'oublie','archive'])->default('brouillon');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('recettes');
    }
};
