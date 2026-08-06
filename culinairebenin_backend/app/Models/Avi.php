<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Avi extends Model
{
    protected $fillable = [
        'utilisateur_id',
        'recette_id',
        'note',
        'commentaire'
    ];

    public function Utilisateur() {
        return $this->belongsTo(Utilisateur::class);
    }

    public function Recette() {
        return $this->belongsTo(Recette::class);
    }
}
