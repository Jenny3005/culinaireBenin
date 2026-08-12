<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ArticleCourse extends Model
{
    protected $fillable = [
        'liste_id',
        'ingredient_id',
        'quantite',
        'unite',
        'achete',
        'prix_estime'
    ];

    public function ListeCourse() {
        return $this->belongsTo(ListeCourse::class);
    }

    public function Ingredient() {
        return $this->belongsTo(Ingredient::class);
    }
}
