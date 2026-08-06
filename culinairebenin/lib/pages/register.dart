import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 250,
          child: Container(
            color: Colors.brown,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Créer un compte',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Rejoignez la communauté des trésors culinaires du Bénin',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 190,
          right:20,
          left:20,
          bottom: 20,

          child :Container (
            color:Colors.white,
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: 
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Nom",
                            hintText: "Votre nom",
                            prefixIcon: const Icon(Icons.person_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        )
                      ),
                      const SizedBox(width: 10),
                      Expanded(child:TextFormField(
                        decoration: InputDecoration(
                          labelText: "Prenom",
                          hintText: "Votre prenom",
                          prefixIcon: const Icon(Icons.person_outlined),
                          border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          )
                        ),
                      ),
                    )
                    
                    ]
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Mot de passe",
                      prefixIcon: const  Icon(Icons.email_outlined), 
                    ),
                  )
                ],
              )
            ),
          )
        ),
      ],)
    );
  }
}