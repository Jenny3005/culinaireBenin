<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Jeu extends Model
{
    protected $table = 'jeux'; // Laravel traduirait sinon par 'jeus'

    protected $fillable = [
        'nom',
        'type',
        'description',
        'niveau_difficulte',
    ];

    public function questions()
    {
        return $this->hasMany(Question::class, 'jeu_id');
    }

    public function parties()
    {
        return $this->hasMany(PartieJeu::class, 'jeu_id');
    }

    public function classements()
    {
        return $this->hasMany(Classement::class, 'jeu_id');
    }
}