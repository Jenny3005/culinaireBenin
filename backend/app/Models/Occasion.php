<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Occasion extends Model
{
    protected $fillable = [
        'nom',
        'description',
        'periode'
    ];

    public function Recettes() {
        return $this->belongsToMany(Recette::class, 'occasion_recette');
    }
}
