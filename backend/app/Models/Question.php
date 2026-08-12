<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Question extends Model
{
    protected $fillable = [
        'jeu_id',
        'recette_id',
        'enonce',
        'type',
        'photo',
        'points',
    ];

    protected $casts = [
        'points' => 'integer',
    ];

    public function jeu()
    {
        return $this->belongsTo(Jeu::class, 'jeu_id');
    }

    public function recette()
    {
        return $this->belongsTo(Recette::class, 'recette_id');
    }

    public function reponses()
    {
        return $this->hasMany(ReponseQuestion::class, 'question_id');
    }
}