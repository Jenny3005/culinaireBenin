<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\Request;
use App\Models\Utilisateur;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    public function register (Request $request) {
        $validated=$request -> validate([
            'nom' =>'required|string|max:255',
            'prenom' =>'required|string|max:255',
            'email' =>'required|string|email|max:255|unique:utilisateurs,email',
            'password'=>'required|min:6|confirmed',
            'region_id' =>'required|exists:regions,id',
            'ethnie_id' => 'required|exists:ethnies,id',
            'level'=>'required'
        ],[
        'nom.required'      => 'Le nom est obligatoire.',
        'prenom.required'   => 'Le prénom est obligatoire.',
        'email.required'    => 'L\'adresse email est obligatoire.',
        'email.email'       => 'Veuillez entrer une adresse email valide.',
        'email.unique'      => 'Cet email est déjà utilisé par un autre compte.',
        'password.required' => 'Le mot de passe est obligatoire.',
        'password.min'      => 'Le mot de passe doit contenir au moins 6 caractères.',
        'region.required'   => 'Veuillez sélectionner une région.',
        'level.required'    => 'Veuillez choisir un niveau.',
        'password.confirmed' => 'Les deux mots de passe ne correspondent pas.',
        ]);

        $user=Utilisateur::create([
            'nom'      => $validated['nom'],
            'prenom'   => $validated['prenom'],
            'email'    => $validated['email'],
            'mot_de_passe' => Hash::make($validated['password']), // 'Hash::make' est recommandé à la place de 'bcrypt'
        ]);

        $user->profil()->create([
            'level'=>$validated['level'],
            'region_id'=>$validated['region_id'],
            'ethnie_id' =>$validated['ethnie_id']
        ]);
        return $user->load('profil');

        return response()->json([
            'success' => true,
            'message' => 'Compte créé avec succès !',
            'user'    => $user,
        ], 201);
    }

    public function login(Request $request)
    {
        // 1. Validation de la requête
        $request->validate([
            'email' => 'required|email',
            'mot_de_passe' => 'required',
        ]);

        // 2. Tentative d'authentification avec la colonne mot_de_passe
        $credentials = [
            'email' => $request->email,
            'password' => $request->mot_de_passe,
        ];

        if (!Auth::attempt($credentials)) {
            return response()->json([
                'status' => false,
                'message' => 'Identifiants incorrects'
            ], 401);
        }

        // 3. Récupération de l'utilisateur connecté
        $user = Auth::user();

        // 4. Envoi de la réponse JSON
        return response()->json([
            'status' => true,
            'message' => 'Connexion réussie !',
            'user' => $user
        ], 200);
    }

}
