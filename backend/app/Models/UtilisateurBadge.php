<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UtilisateurBadge extends Model
{
    protected $fillable = [
        'utilisateur_id',
        'badge_id',
        'obtenue_le'
    ];

    public function Utilisateur() {
        return $this->belongsTo(Utilisateur::class);
    }

    public function Badge() {
        return $this->belongsTo(Badge::class);
    }
}
