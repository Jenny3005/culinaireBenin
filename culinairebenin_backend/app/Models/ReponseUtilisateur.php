<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ReponseUtilisateur extends Model
{
    protected $table = 'reponse_utilisateurs';

    protected $fillable = [
        'partie_id',
        'question_id',
        'reponse_id',
        'est_correct',
        'temps_reponse_ms',
    ];

    protected $casts = [
        'est_correct' => 'boolean',
        'temps_reponse_ms' => 'integer',
    ];

    public function partie()
    {
        return $this->belongsTo(PartieJeu::class, 'partie_id');
    }

    public function question()
    {
        return $this->belongsTo(Question::class, 'question_id');
    }

    public function reponse()
    {
        return $this->belongsTo(ReponseQuestion::class, 'reponse_id');
    }
}