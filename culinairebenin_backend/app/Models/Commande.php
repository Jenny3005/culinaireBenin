<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Commande extends Model
{
    protected $fillable = [
        'utilisateur_id',
        'restaurant_id',
        'type',
        'statut',
        'date_commande',
        'montant_total',
        'adresse_livraison',
    ];

    public function User() {
        return $this->belongsTo(Utilisateur::class, 'utilisateur_id');
    }

    public function Restaurant() {
        return $this->belongsTo(Restaurant::class, 'restaurant_id');
    }
}
