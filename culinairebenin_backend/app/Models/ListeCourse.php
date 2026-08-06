<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ListeCourse extends Model
{
    protected $fillable = [
        'utilisateur_id',
        'nom',
    ];

    public function Utilisateur() {
        return $this->belongsTo(Utilisateur::class);
    }

    public function ArticleCourses() {
        return $this->hasMany(ArticleCourse::class);
    }
}
