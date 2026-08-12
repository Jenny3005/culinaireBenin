<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Reservation extends Model
{
    protected $fillable = [
        'utilisateur_id',
        'restaurant_id',
        'date_reservation',
        'nb_personnes',
        'statut',
        'notes'
    ];

    public function Utilisateur() {
        return $this->belongsTo(Utilisateur::class);
    }

    public function Restaurant() {
        return $this->belongsTo(Restaurant::class);
    }
}
