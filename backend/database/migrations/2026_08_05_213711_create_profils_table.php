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
        Schema::create('profils', function (Blueprint $table) {
            $table->id();
            $table->foreignId('utilisateur_id')->constrained('utilisateurs')->onDelete('cascade');
            $table->foreignId('ethnie_id')->constrained('ethnies')->onDelete('cascade');
            $table->foreignId('region_id')->constrained('regions')->onDelete('cascade');
            $table->enum('niveau_cuisine', ['débutant', 'intermédiaire', 'avancé'])->default('débutant');
            $table->integer('points_fidelite')->default(0);
            $table->string('allergies')->nullable();
            $table->enum('regime_alimentaire', ['végétarien', 'végan', 'sans glutén','omnivore', 'autre'])->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('profils');
    }
};
