<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Historique extends Model
{
    protected $fillable = [
        'utilisateur_id',
        'recette_id',
        'date_consultation'
    ];

    public function Utilisateur() {
        return $this->belongsTo(Utilisateur::class);
    }

    public function Recette() {
        return $this->belongsTo(Recette::class);
    }
}
