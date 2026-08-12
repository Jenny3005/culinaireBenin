<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Profil extends Model
{
    protected $fillable = [
        'utilisateur_id',
        'region_id',
        'ethnie_id',
        'niveau_cuisine',
        'points_fidelite',
        'allergies',
        'regime_alimentaire'
    ];

    public function Utilisateur() {
        return $this->belongsTo(Utilisateur::class);
    }

    public function Region() {
        return $this->belongsTo(Region::class);
    }

    public function Ethnie() {
        return $this->belongsTo(Ethnie::class);
    }
}
