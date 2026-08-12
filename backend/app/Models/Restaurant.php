<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Restaurant extends Model
{
    protected $fillable = [
        'nom',
        'description',
        'adresse',
        'ville',
        'telephone',
        'email',
        'photo',
        'latitude',
        'longitude',
        'horaires',
        'est_ouvert',
        'categorie_id',
        'region_id'
    ];

    public function Categorie() {
        return $this->belongsTo(Categorie::class);
    }

    public function Region() {
        return $this->belongsTo(Region::class);
    }

    public function AvisRestaurants() {
        return $this->hasMany(AvisRestaurant::class);
    }

    public function Menus() {
        return $this->hasMany(Menu::class);
    }

    public function Reservations() {
        return $this->hasMany(Reservation::class);
    }

    public function UtilisateursFavoris() {
        return $this->belongsToMany(Utilisateur::class, 'favoris_restaurants');
    }

    public function Commandes() {
        return $this->hasMany(Commande::class);
    }
}
