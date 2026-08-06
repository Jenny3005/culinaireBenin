<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class MenuItem extends Model
{
    protected $fillable = [
        'menu_id',
        'nom',
        'description',
        'prix',
        'photo',
        'disponible',
    ];

    public function Menu() {
        return $this->belongsTo(Menu::class);
    }

    public function LigneCommandes() {
        return $this->hasMany(LigneCommande::class);
    }
}
