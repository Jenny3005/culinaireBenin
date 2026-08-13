<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\EthnieController;
use App\Http\Controllers\RegionController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::get('/regions',[RegionController::class,'index']);

Route::post('/register',[AuthController::class,'register']);

Route::get('/ethnies',[EthnieController::class,'index']);
