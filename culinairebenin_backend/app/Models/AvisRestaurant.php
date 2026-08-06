<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AvisRestaurant extends Model
{
    protected $fillable = [
        'utilisateur_id',
        'restaurant_id',
        'note',
        'commentaire'
    ];

    public function Utilisateur() {
        return $this->belongsTo(Utilisateur::class);
    }

    public function Restaurant() {
        return $this->belongsTo(Restaurant::class);
    }
}
