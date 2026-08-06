<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class MediaRecette extends Model
{
    protected $fillable = [
        'recette_id',
        'type',
        'url',
        'est_principal'
    ];

    public function Recette() {
        return $this->belongsTo(Recette::class);
    }
}
