<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Menu extends Model
{
    protected $fillable = [
        'nom',
        'description',
        'restaurant_id'
    ];

    public function Restaurant() {
        return $this->belongsTo(Restaurant::class);
    }

    public function MenuItems() {
        return $this->hasMany(MenuItem::class);
    }
}
