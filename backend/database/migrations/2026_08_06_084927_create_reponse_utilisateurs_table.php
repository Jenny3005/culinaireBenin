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
        Schema::create('reponse_utilisateurs', function (Blueprint $table) {
            $table->id();
            $table->foreignId('partie_id')->constrained('partie_jeux')->onDelete('cascade');
            $table->foreignId('question_id')->constrained('questions')->onDelete('cascade');
            $table->foreignId('reponse_id')->nullable()->constrained('reponse_questions')->onDelete('cascade');
            $table->boolean('est_correct')->default(false);
            $table->integer('temps_reponse_ms')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('reponse_utilisateurs');
    }
};
