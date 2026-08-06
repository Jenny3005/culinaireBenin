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
        Schema::create('partie_jeux', function (Blueprint $table) {
            $table->id();
            // Ajuste 'utilisateurs' ou 'users' selon le nom de ta table utilisateur
            $table->foreignId('utilisateur_id')->constrained('utilisateurs')->onDelete('cascade');
            $table->foreignId('jeu_id')->constrained('jeux')->onDelete('cascade');
            $table->integer('score_obtenu')->default(0);
            $table->integer('nb_bonnes_reponses')->default(0);
            $table->integer('duree_secondes')->nullable();
            $table->timestamp('date_partie')->useCurrent();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('partie_jeus');
    }
};
