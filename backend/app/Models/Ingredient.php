<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Ingredient extends Model
{
    protected $fillable = [
        'nom',
        'unite_mesure',
        'prix_unitaire',
        'categorie'
    ];

}
