<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Utilisateur extends Model
{
    protected $fillable = [
        'nom',
        'prenom',
        'email',
        'mot_de_passe',
        'photo',
        'role',
        'telephone'
    ];

    public function Reservations() {
        return $this->hasMany(Reservation::class);
    }

    public function PlanRepas() {
        return $this->hasMany(PlanRepa::class);
    }

    public function Profil() {
        return $this->hasOne(Profil::class);
    }

    public function Badges() {
        return $this->belongsToMany(Badge::class, 'utilisateur_badges');
    }

    public function AvisRecettes() {
        return $this->hasMany(Avi::class);
    }

    public function AvisRestaurants() {
        return $this->hasMany(AvisRestaurant::class);
    }

    public function Jeux() {
        return $this->belongsToMany(Jeu::class, 'classements');
    }

    public function Favoris() {
        return $this->belongsToMany(Restaurant::class, 'favoris_restaurants');
    }

    public function Notifications() {
        return $this->hasMany(Notification::class);
    }

    public function ListeCourses() {
        return $this->hasMany(ListeCourse::class);
    }

    public function Commandes() {
        return $this->hasMany(Commande::class);
    }

}
