<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Paiement extends Model
{
    protected $fillable = [
        'commande_id',
        'mode',
        'montant',
        'methode',
        'statut',
        'reference',
        'numero_telephone'
    ];

    public function Commande() {
        return $this->belongsTo(Commande::class);
    }
}
