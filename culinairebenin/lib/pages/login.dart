import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../models/utilisateur.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController =TextEditingController();
  final TextEditingController passwordController=TextEditingController();

  Future<void> submitForm() async {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Connexion en cours ..."),
        duration :Duration(seconds: 2),  
      )
    );
    
    final String ipMonPC = '192.168.100.13';
    final String host=kIsWeb ? 'localhost' :ipMonPC;
    final Uri url=Uri.parse('http://$host:8000/api/login');

    try {
      final response=await http.post(
        url,
        headers: {'Accept':'application/json','Content-Type': 'application/json'},
        body: jsonEncode({
        'email':emailController.text.trim(),
        'mot_de_passe':passwordController.text.trim()
        }),
      );
      
      if (!mounted) return;
      if (response.statusCode==200 || response.statusCode==201) {
        final data = jsonDecode(response.body);

        // 1. Extraire l'utilisateur du JSON reçu de Laravel
        // (Ajuste 'user' selon le nom exact de la clé retournée par ton API Laravel)
        Utilisateur userConnecte = Utilisateur.fromJson(data['user']);

        // 2. Transmettre l'utilisateur à ton AuthProvider !
        Provider.of<AuthProvider>(context, listen: false).setUtilisateur(userConnecte);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Connexion réussie"), 
            backgroundColor: Colors.green,
          )
        );

        Navigator.popAndPushNamed(context, '/home');
      } else {
        print("Détails de l'erreur serveur (${response.statusCode}) : ${response.body}");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur (${response.statusCode}) : ${response.body}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    } catch (e) {
      print("Erreur de connexion : $e");

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Impossible de contacter le serveur. Vérifiez votre connexion API : $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
    }

  }

  Future<Utilisateur?> connecterUtilisateur(String email, String password) async {
    final String ipMonPC = '192.168.100.13';

    final String host=kIsWeb ? 'localhost' :ipMonPC;
    final Uri url=Uri.parse('http://$host:8000/api/login');
    final response = await http.post(
      url, // adresse de ton backend Laravel
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {'email': email, 'mot_de_passe': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // 1. Transformation du JSON en objet Utilisateur
      Utilisateur userConnecte = Utilisateur.fromJson(data['user']);
      
      // 2. Récupération du token Sanctum
      String token = data['token'];

      return userConnecte;
    } else {
      print("Erreur de connexion");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 250,
            child: Container(
              color: Colors.brown,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', width: 100, height: 100),
                const SizedBox(height: 5),
                Text('Trésors Culinaires du Bénin')
              ],
            ),)
          ),
          Positioned(
            top: 200,
            right: 20,
            left: 20,
            
            child: Container(
              height: 300,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: [
                  const SizedBox(height: 10,),
                  Text("Bienvenue !",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),),
                  const SizedBox(height: 10,),
                  Text("Connectez vous pour découvrir les saveurs du Bénin",
                  ),
                  const SizedBox(height: 15,),
                  TextField(
                    controller:emailController,
                    decoration: InputDecoration(
                    hintText: "votre@email.com",
                    labelText: "Adresse email",
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                    )
                  ),),
                  const SizedBox(height: 15,),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Mot de passe",
                      hintText: "*****",
                      prefixIcon: Icon(Icons.lock_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )
                    ),
                  ),
                  const SizedBox(height: 15,),
                  
                  Row(children: [
                    Expanded(child:ElevatedButton(onPressed: (submitForm),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12)
                    ),
                    child: Text("Se connecter") ))
                  ],)
                ],
              ),
            ))
        ],
      ),
    );
  }
}