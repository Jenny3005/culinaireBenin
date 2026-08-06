<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PartieJeu extends Model
{
    protected $table = 'partie_jeux';

    protected $fillable = [
        'utilisateur_id',
        'jeu_id',
        'score_obtenu',
        'nb_bonnes_reponses',
        'duree_secondes',
        'date_partie',
    ];

    protected $casts = [
        'score_obtenu' => 'integer',
        'nb_bonnes_reponses' => 'integer',
        'duree_secondes' => 'integer',
        'date_partie' => 'datetime',
    ];

    public function utilisateur()
    {
        return $this->belongsTo(Utilisateur::class, 'utilisateur_id');
    }

    public function jeu()
    {
        return $this->belongsTo(Jeu::class, 'jeu_id');
    }

    public function reponsesUtilisateur()
    {
        return $this->hasMany(ReponseUtilisateur::class, 'partie_id');
    }
}
