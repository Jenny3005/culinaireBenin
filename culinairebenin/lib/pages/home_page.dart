import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
      final authProvider = Provider.of<AuthProvider>(context);
      final user = authProvider.utilisateur;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: false,
        title: Text('Bonjour, ${user?.prenom ?? "Invité"}',style: TextStyle(
          fontSize: 18,
          fontWeight:FontWeight.bold
        ),),
      ),
      body: Center(
        child: Text ("Trésors Culinaires du Bénin")
      ),
      

      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined),selectedIcon: Icon(Icons.home), label: 'Accueil'),
          NavigationDestination(icon: Icon(Icons.restaurant_menu_outlined),selectedIcon: Icon(Icons.restaurant_menu), label: 'Recettes'),
          NavigationDestination(icon: Icon(Icons.language_outlined),selectedIcon: Icon(Icons.language), label: 'Explorer'),
          NavigationDestination(icon: Icon(Icons.table_restaurant_outlined),selectedIcon: Icon(Icons.table_restaurant), label: 'Restaurants'),
          NavigationDestination(icon: Icon(Icons.sports_esports_outlined),selectedIcon: Icon(Icons.sports_esports), label: 'Jeux')
        ]
      ),
    );
  }
}
