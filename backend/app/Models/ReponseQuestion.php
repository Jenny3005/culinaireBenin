<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ReponseQuestion extends Model
{
    protected $table = 'reponse_questions';

    protected $fillable = [
        'question_id',
        'texte',
        'est_correcte',
    ];

    protected $casts = [
        'est_correcte' => 'boolean',
    ];

    public function question()
    {
        return $this->belongsTo(Question::class, 'question_id');
    }
}