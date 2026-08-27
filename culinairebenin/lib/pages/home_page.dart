import 'dart:convert';
import 'package:culinairebenin/pages/recettes.dart';
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

  final List<Widget> _pages = [
    const HomeContent(),
    const RecettePage(),
    const Center(child: Text("Page Explorer")),
    const Center(child: Text("Page Restaurants")),
    const Center(child: Text("Page Jeux")),
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

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
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.grade_outlined)),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
          Material(
            color: Colors.transparent, // Garde le fond transparent
            shape:
                const CircleBorder(), // Conserve la forme circulaire pour l'effet de clic
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              mouseCursor: SystemMouseCursors
                  .click, // Force le curseur en forme de main sur Web/Desktop
              onTap: () {
                Navigator.pushNamed(context, '/profil');
              },
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.deepOrange,
                child: Text(
                  initiale,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
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
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Rechercher une recette, un restaurant...",
                prefixIcon: const Icon(Icons.search),
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
      body: IndexedStack(index: _selectedIndex, children: _pages),
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
  int selectedCategoryIndex = 0;

  final ScrollController _categoryScrollController = ScrollController();
  final ScrollController _restaurantScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  @override
  void dispose() {
    _categoryScrollController.dispose();
    _restaurantScrollController.dispose();
    super.dispose();
  }

  Future<void> fetchCategories() async {
    const String ipMonPC = '192.168.100.13';
    final String host = kIsWeb ? 'localhost' : ipMonPC;
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
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // PLAN DE REPAS DU JOUR
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 15.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
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
                      const Text(
                        "Midi: Amiwo - Soir : Gbègiri",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Voir +",
                          style: TextStyle(color: Colors.deepOrange),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
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
                        color: Color(0xFFFFD700),
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

          // PLAT DU JOUR
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(200, 1, 82, 4),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "PLAT DU JOUR",
                    style: TextStyle(color: Colors.yellow, fontSize: 12),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: const [
                      Text(
                        "Amiwo",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text("Image ooh", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    "Pâte de maïs rouge - Sud Bénin - Fon",
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: const [
                      Icon(
                        Icons.local_fire_department,
                        color: Colors.deepOrange,
                        size: 15,
                      ),
                      SizedBox(width: 3),
                      Text(
                        "450 kcal",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.timer, size: 15, color: Colors.white),
                      SizedBox(width: 3),
                      Text(
                        "45 min",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.group, size: 15, color: Colors.white),
                      SizedBox(width: 3),
                      Text(
                        "4 pers.",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Facile",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 15),

          // SECTION CATEGORIES
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Catégories",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),

          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Scrollbar(
                  controller: _categoryScrollController,
                  thumbVisibility: true,
                  trackVisibility: true,
                  child: SizedBox(
                    height: 60,
                    child: ListView.builder(
                      controller: _categoryScrollController,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final item = categories[index];
                        final bool isSelected = selectedCategoryIndex == index;

                        return Container(
                          margin: const EdgeInsets.only(right: 8, bottom: 12),
                          child: ChoiceChip(
                            label: Text(
                              item['nom'] ?? 'Catégorie',
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black87,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            selected: isSelected,
                            selectedColor: const Color(0xFFFF5722),
                            backgroundColor: Colors.white,
                            showCheckmark: false,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: isSelected
                                    ? Colors.deepOrange
                                    : Colors.transparent,
                              ),
                            ),
                            onSelected: (bool selected) {
                              setState(() {
                                selectedCategoryIndex = index;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),

          // RECETTES POPULAIRES
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Recettes populaires",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Voir tout",
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Amiwo",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.location_on,
                                size: 12,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 3),
                              Text(
                                "Sud Bénin",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Row(
                                children: [
                                  Icon(
                                    Icons.local_fire_department,
                                    color: Colors.deepOrange,
                                    size: 12,
                                  ),
                                  SizedBox(width: 3),
                                  Text(
                                    "450 kcal",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Facile",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 15),

          // BANNIERE ASSISTANT IA
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.topRight,
                colors: [Color(0xFF190F14), Color(0xFF381912)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  children: const [
                    Icon(Icons.smart_toy, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      "Assistant IA",
                      style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '"Je veux un repas béninois riche en protéines..."',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[400],
                          fontSize: 13,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Essayer"),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          // RESTAURANTS PROCHES
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Restaurants proches",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Voir tout",
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                ),
              ],
            ),
          ),

          Scrollbar(
            controller: _restaurantScrollController,
            thumbVisibility: true,
            trackVisibility: true,
            child: SizedBox(
              height: 175, // Hauteur indispensable pour le ListView horizontal
              child: ListView.builder(
                controller: _restaurantScrollController,
                scrollDirection: Axis.horizontal,

                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    width: 200,
                    margin: const EdgeInsets.only(
                      right: 10,
                      left: 10,
                      bottom: 12,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 90,
                            width: double.infinity,
                            child: Image.network(
                              "https://tse3.mm.bing.net/th/id/OIP.NrwSsZgFWG1mtp8pyUcKawAAAA?r=0&rs=1&pid=ImgDetMain&o=7&rm=3",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Face à la mer",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  'Haie Vive, Cotonou',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: const [
                                    Text(
                                      "Ouvert",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 11,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.delivery_dining,
                                      color: Colors.green,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 10),

          // BANNIERE CONTRIBUER
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.topRight,
                colors: [
                  Color(0xFFD69300),
                  Color(0xFFC96E00),
                  Color(0xFFC24C00),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  children: const [
                    Icon(Icons.edit, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      "Contribuer",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Partagez une recette de votre région !",
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Soumettre"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
