<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PlanRepa extends Model
{
    protected $fillable = [
        'utilisateur_id',
        'semaine_debut'
    ];

    public function Utilisateur() {
        return $this->belongsTo(Utilisateur::class);
    }

    public function PlanRepasDetails() {
        return $this->hasMany(PlanRepasDetail::class);
    }
}
