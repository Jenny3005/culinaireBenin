import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int? selectedEthnieId;
  int? selectedRegionId;
  String selectedLevel = 'Débutant';

  List<Map<String, dynamic>> regions = [];
  List<Map<String, dynamic>> ethnies = [];
  bool isLoadingRegions = true;
  bool isLoadingEthnies=true;

  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();

  // Libérer les ressources à la fermeture du widget
  @override
  void dispose() {
    nomController.dispose();
    prenomController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchRegions();
    fetchEthnies();
  }

  Future<void> fetchEthnies() async {
    final String host = kIsWeb ? 'localhost':'10.0.2.2';
    final Uri url = Uri.parse('http://$host:8000/api/ethnies');

    try {
      final response = await http.get(url,headers: {'Accept' :'application/json'});

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        setState(() {
          ethnies = List<Map<String, dynamic>>.from(data);

          isLoadingEthnies = false;
        });
      }
    } catch (e) {
      print("Erreur de chargement des ethnies :$e");
      setState(() {
        isLoadingEthnies = false;
      });
    }
  }

  Future<void> fetchRegions() async {
    final String host = kIsWeb ? 'localhost' : '10.0.2.2';
    final Uri url = Uri.parse('http://$host:8000/api/regions');

    try {
      final response = await http.get(url, headers: {'Accept': 'application/json'});

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        setState(() {
          regions = List<Map<String, dynamic>>.from(data);

          isLoadingRegions = false;
        });
      }
    } catch (e) {
      print("Erreur de chargement des régions : $e");
      setState(() {
        isLoadingRegions = false;
      });
    }
  }

  Future<void> submitForm() async {

    // 2. Afficher un message de chargement
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Inscription en cours...'),
        duration: Duration(seconds: 2),
      ),
    );

    final String host = kIsWeb ? 'localhost' : '10.0.2.2';
    final Uri url = Uri.parse('http://$host:8000/api/register');

    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'nom': nomController.text.trim(),
          'prenom': prenomController.text.trim(),
          'email': emailController.text.trim(),
          'password': passwordController.text,
          'password_confirmation': passwordConfirmController.text,
          'ethnie_id': selectedEthnieId,
          'region_id': selectedRegionId,
          'level': selectedLevel,
        }),
      );

      if (!mounted) return;

      if (response.statusCode == 200 || response.statusCode == 201) {
        // SUCCÈS
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Compte créé avec succès !'),
            backgroundColor: Colors.green,
          ),
        );
        
        Navigator.pushReplacementNamed(context, '/login');

      } else {
        //  ERREUR DU SERVEUR (ex: Code 422 si l'email existe déjà dans Laravel)
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
      // ERREUR RÉSEAU / CONNEXION
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
  
  final List<String> levels = ['Débutant', 'Intermédiaire', 'Professionnel'];

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
            right: 20,
            left: 20,
            bottom: 20,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: nomController,
                            decoration: InputDecoration(
                              labelText: "Nom",
                              hintText: "Votre nom",
                              prefixIcon: const Icon(Icons.person_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: prenomController,
                            decoration: InputDecoration(
                              labelText: "Prenom",
                              hintText: "Votre prenom",
                              prefixIcon: const Icon(Icons.person_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Votre Email",
                        hintText: "votreadresse@gmail.com",
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Mot de passe",
                        hintText: "******",
                        prefixIcon: const Icon(Icons.lock_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: passwordConfirmController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Confirmer votre mot de passe",
                        hintText: "******",
                        prefixIcon: const Icon(Icons.lock_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    isLoadingEthnies 
                      ? const Center(child: CircularProgressIndicator())
                      : DropdownButtonFormField<int>(
                        value: selectedEthnieId,
                        decoration: InputDecoration(
                          labelText: "Votre ethnie",
                          hintText: "Choisissez votre ethnie",
                          prefixIcon: const Icon(Icons.language),
                          border : OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        items: ethnies.map((ethnie) {
                          return DropdownMenuItem<int>(
                            value: ethnie['id'] as int,
                            child: Text(ethnie['nom'].toString())
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedEthnieId = value;
                          });
                        },
                        validator: (value) => value == null ? "Veuillez choisir une ethnie" : null,
                      ),
                    const SizedBox(height: 15),
                    isLoadingRegions
                      ? const Center(child:CircularProgressIndicator())
                      : DropdownButtonFormField<int>(
                      value: selectedRegionId,
                      decoration: InputDecoration(
                        labelText: "Votre Région",
                        hintText: "Sélectionez votre région",
                        prefixIcon: const Icon(Icons.location_on_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: regions.map((region) {
                        return DropdownMenuItem<int>(
                          value: region['id'] as int,
                          child: Text(region['nom'].toString()),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedRegionId = value;
                        });
                      },
                      validator: (value) => value == null ? 'Veuillez choisir une région' : null,
                    ),
                    
                    const SizedBox(height: 15),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Niveau de cuisine',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Génération dynamique et propre des cartes
                    Row(
                      children: levels.map((level) {
                        final isSelected = selectedLevel == level;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedLevel = level;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFAF5EF),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected ? Colors.deepOrange : Colors.transparent,
                                    width: 1.5,
                                  ),
                                ),
                                child: Text(
                                  level,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    color: isSelected ? Colors.deepOrange : Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 10),
                    Row(children: [
                      Expanded(child: 
                        ElevatedButton(onPressed: submitForm,
                          style:ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: const Text('Créer mon compte'),
                        ),
                      ),
                    ],),
                    const SizedBox(height:12),
                    Row(children: [
                      Text("Déjà un compte ?"),
                      TextButton(onPressed: () => Navigator.pushReplacementNamed(context, '/login'), 
                      child: Text('Se connecter',style: TextStyle(color: Colors.deepOrange),))
                    ],)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}