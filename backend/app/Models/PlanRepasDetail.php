<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PlanRepasDetail extends Model
{
    protected $fillable = [
        'plan_repas_id',
        'recette_id',
        'jour_semaine',
        'moment_journee'
    ];

    public function PlanRepas() {
        return $this->belongsTo(PlanRepa::class);
    }

    public function Recette() {
        return $this->belongsTo(Recette::class);
    }
}
