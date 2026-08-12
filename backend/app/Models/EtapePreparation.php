<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class EtapePreparation extends Model
{
    protected $fillable = [
        'recette_id',
        'numero_ordre',
        'description',
        'duree_minutes',
        'photo',
        'video'
    ];

    public function Recette() {
        return $this->belongsTo(Recette::class);
    }
}
