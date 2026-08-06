<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Recette extends Model
{
    protected $fillable = [
        'nom',
        'description',
        'temps_preparation',
        'temps_cuisson',
        'difficulte',
        'prix_estime',
        'categorie_id',
        'region_id',
        'ethnie_id',
        'occasion_id',
        'auteur_id',
        'histoire_culturelle',
        'valeur_calorique',
        'statut'
    ];

    public function Categorie() {
        return $this->belongsTo(Categorie::class);
    }

    public function Ethnie() {
        return $this->belongsTo(Ethnie::class);
    }

    public function Region() {
        return $this->belongsTo(Region::class);
    }

    public function Occasion() {
        return $this->belongsTo(Occasion::class);
    }

    public function Auteur() {
        return $this->belongsTo(Utilisateur::class, 'auteur_id');
    }

    public function EtapesPreparation() {
        return $this->hasMany(EtapePreparation::class);
    }

    public function RecetteIngredients() {
        return $this->hasMany(RecetteIngredient::class);
    }

    public function Avis() {
        return $this->hasMany(Avi::class);
    }

    public function MediaRecettes() {
        return $this->hasMany(MediaRecette::class);
    }

    public function PlanRepasDetails() {
        return $this->hasMany(PlanRepasDetail::class);
    }

    public function Jeux() {
        return $this->belongsToMany(Jeu::class, 'jeu_recette');
    }

    public function Questions() {
        return $this->hasMany(Question::class);
    }

    public function Favoris() {
        return $this->hasMany(Favori::class);
    }

    public function Historique() {
        return $this->hasMany(Historique::class);
    }

    public function ArticleCourses() {
        return $this->hasMany(ArticleCourse::class);
    }
}
