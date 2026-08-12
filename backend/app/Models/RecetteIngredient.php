<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class RecetteIngredient extends Model
{
    protected $fillable = [
        'recette_id',
        'ingredient_id',
        'quantite_base',
        'nb_personne_base',
        'substitut'
    ];

    public function Recette() {
        return $this->belongsTo(Recette::class);
    }

    public function Ingredient() {
        return $this->belongsTo(Ingredient::class);
    }
}
