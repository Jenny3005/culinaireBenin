<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Badge extends Model
{
    protected $fillable = [
        'nom',
        'description',
        'icone',
        'points_requis'
    ];

    public function Utilisateurs() {
        return $this->belongsToMany(Utilisateur::class, 'utilisateur_badges');
    }
}
