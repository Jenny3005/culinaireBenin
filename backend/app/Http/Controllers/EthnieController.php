<?php

namespace App\Http\Controllers;

use App\Models\Ethnie;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class EthnieController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index():JsonResponse
    {
        $ethnies=Ethnie::select('id','nom')->get();
        return response()->json($ethnies,200);

        
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(Ethnie $ethnie)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Ethnie $ethnie)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Ethnie $ethnie)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Ethnie $ethnie)
    {
        //
    }
}
