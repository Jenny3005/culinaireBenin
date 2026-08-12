<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Region extends Model
{
    protected $fillable = [
        'nom',
        'description',
        'latitude',
        'longitude'
    ];

    public function Restaurants() {
        return $this->hasMany(Restaurant::class);
    }

    public function Recettes() {
        return $this->hasMany(Recette::class);
    }

    public function Profils() {
        return $this->hasMany(Profil::class);
    }
}
