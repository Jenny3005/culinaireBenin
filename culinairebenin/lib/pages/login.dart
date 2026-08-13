import 'package:flutter/material.dart';
import 'dart:async';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                  TextField(decoration: InputDecoration(
                    hintText: "votre@email.com",
                    labelText: "Adresse email",
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                    )
                  ),),
                  const SizedBox(height: 15,),
                  TextField(
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
                    Expanded(child:ElevatedButton(onPressed: () {},
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