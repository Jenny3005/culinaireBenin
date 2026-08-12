<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class LigneCommande extends Model
{
    protected $fillable = [
        'commande_id',
        'menu_item_id',
        'quantite',
        'prix_unitaire'
    ];

    public function Commande() {
        return $this->belongsTo(Commande::class);
    }

    public function MenuItem() {
        return $this->belongsTo(MenuItem::class);
    }
}
