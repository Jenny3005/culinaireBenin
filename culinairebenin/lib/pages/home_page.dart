import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController searchController = TextEditingController();
  int _selectedIndex = 0;

  final List<Widget> _pages = [const HomeContent()];

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.utilisateur;

    final String prenom = user?.prenom ?? '';
    final String initiale = prenom.isNotEmpty ? prenom[0].toUpperCase() : '?';
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: false,
        title: Text(
          'Bonjour, ${user?.prenom ?? "Invité"}',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.grade_outlined)),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_outlined),
          ),
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.deepOrange,
            child: Text(initiale),
          ),
          const SizedBox(width: 16),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: TextField(
              controller: SearchController(),
              decoration: InputDecoration(
                hintText: "Rechercher une recette, un restaurant...",
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: const Color.fromARGB(85, 238, 238, 238),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: _pages[_selectedIndex],

      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Accueil',
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu_outlined),
            selectedIcon: Icon(Icons.restaurant_menu),
            label: 'Recettes',
          ),
          NavigationDestination(
            icon: Icon(Icons.language_outlined),
            selectedIcon: Icon(Icons.language),
            label: 'Explorer',
          ),
          NavigationDestination(
            icon: Icon(Icons.table_restaurant_outlined),
            selectedIcon: Icon(Icons.table_restaurant),
            label: 'Restaurants',
          ),
          NavigationDestination(
            icon: Icon(Icons.sports_esports_outlined),
            selectedIcon: Icon(Icons.sports_esports),
            label: 'Jeux',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  List<dynamic> categories = [];
  bool isLoading = true;
  final ScrollController _categoryScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    // 10.0.2.2 est l'adresse IP correcte pour l'émulateur Android
    final String host = kIsWeb ? 'localhost' : '10.0.2.2';
    final Uri url = Uri.parse('http://$host:8000/api/categories');

    try {
      final response = await http.get(
        url,
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        setState(() {
          categories = jsonDecode(response.body);
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Erreur lors de la récupération des catégories : $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisSize:
                    MainAxisSize.min, // ⚠️ Ajuste la hauteur au contenu
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_month, color: Colors.blue, size: 20),
                      SizedBox(width: 8),
                      Text(
                        "PLAN DE REPAS DU JOUR",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Text(
                        "Midi: Amiwo - Soir : Gbègiri",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Voir + ",
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.deepOrange),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Icon(
                        Icons.local_fire_department,
                        color: Colors.deepOrange,
                        size: 15,
                      ),
                      SizedBox(width: 2),
                      Text(
                        "770 kcal estimées - ",
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                      Icon(
                        Icons.attach_money,
                        color: const Color(0xFFFFD700),
                        size: 15,
                      ),
                      SizedBox(width: 2),
                      Text(
                        "3 125 FCFA",
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(200, 1, 82, 4),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, //  Ajuste la hauteur au contenu
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "PLAT DU JOUR",
                        style: TextStyle(color: Colors.yellow, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Text(
                        "Amiwo",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text("Image ooh"),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Text(
                        "Pâte de maïs rouge- Sud Bénin - Fon",
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(
                        Icons.local_fire_department,
                        color: Colors.deepOrange,
                        size: 15,
                      ),
                      SizedBox(width: 3),
                      Text("450 kcal", style: TextStyle(fontSize: 10)),
                      SizedBox(width: 3),
                      Icon(Icons.timer, size: 15),
                      SizedBox(width: 3),
                      Text("45 min", style: TextStyle(fontSize: 10)),
                      SizedBox(width: 3),
                      Icon(Icons.group, size: 15),
                      SizedBox(width: 3),
                      Text("4 pers.", style: TextStyle(fontSize: 10)),
                      SizedBox(width: 10),
                      Text(
                        "Facile",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Catégories",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Scrollbar(
                      controller: _categoryScrollController,
                      thumbVisibility:
                          true, // Force la barre à rester toujours visible
                      trackVisibility:
                          true, // Affiche la piste de la barre sous le curseur
                      child: SizedBox(
                        height:
                            50, // On augmente légèrement la hauteur pour laisser de la place à la barre
                        child: ListView.builder(
                          controller:
                              _categoryScrollController, // On associe le même controller
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final item = categories[index];
                            return Container(
                              margin: const EdgeInsets.only(
                                left: 8,
                                bottom: 18,
                              ),
                              child: Chip(
                                label: Text(item['nom'] ?? 'Catégorie'),
                                backgroundColor: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Text(
                      "Recettes populaires",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Voir tout ",
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.deepOrange),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: Image.network(
                          "https://tse4.mm.bing.net/th/id/OIP.KoOzfLXwRAI-Ex-bKd2fYgHaFP?r=0&rs=1&pid=ImgDetMain&o=7&rm=3",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        "Amiwo",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 12),
                          const SizedBox(width: 5,),
                          Text(
                            "Sud Bénin",
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.local_fire_department,color: Colors.deepOrange,size: 12,),
                          const SizedBox(width: 5,),
                          Text("450 kcal",style: TextStyle(fontSize: 10,color: Colors.deepOrange),),
                          const Spacer(),
                          Text("Facile",style: TextStyle(
                            color: Colors.green,
                           
                            
                          ),)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color(0xFF190F14), // Marron / violet très sombre à gauche
                      Color(0xFF381912), // Marron orangé chaud en haut à droite
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                
                child: Column(
                  children: [
                    
                    Row(
                      children: [
                        Icon(Icons.smart_toy, color: Colors.white),
                        const SizedBox(width: 15),
                        Text(
                          "Assistant IA",
                          style: TextStyle(color: Colors.amber),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2,),
                   
                    Row(
                      children: [
                        Text(
                          '"Je veux un repas béninois riche en protéines..."',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50, right: 10 ,bottom: 5,top: 0),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text("Essayer"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 15),

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
