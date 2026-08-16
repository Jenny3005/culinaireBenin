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
  final TextEditingController serachController = TextEditingController();

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
        title: Text('Bonjour, ${user?.prenom ?? "Invité"}',style: TextStyle(
          fontSize: 18,
          fontWeight:FontWeight.bold
        ),),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.grade_outlined)),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_outlined)),
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.deepOrange,
            child : Text(
              initiale,
            )
          ),
          const SizedBox(width: 16),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0), 
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller:SearchController(),
              decoration: InputDecoration(
                hintText: "Rechercher une recette, un restaurant...",
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: const Color.fromARGB(85, 238, 238, 238),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                )
              ),
            ),
          )
        )
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          
          child: Column(
          mainAxisSize: MainAxisSize.min, // ⚠️ Ajuste la hauteur au contenu
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [
            Row(
              
              children: [
                Icon(Icons.calendar_month,
                color: Colors.blue,
                size: 20,),
                SizedBox(width: 8,),
                Text("PLAN DE REPAS DU JOUR",style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),)
              ],
            ),
            
            Row(
             
              children: [
                Text("Midi: Amiwo - Soir : Gbègiri",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15)
                ),
                const Spacer(),
                TextButton(onPressed: () {}, child: Text("Voir + ",textAlign: TextAlign.right,style: TextStyle(
                  color:Colors.deepOrange,
                  
                ),))
              ],
            ),
            
            Row(
              
              children: [
                Icon(Icons.local_fire_department,
                color: Colors.deepOrange,
                size:15),
                SizedBox(width: 2,),
                Text("770 kcal estimées - ",style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey
                ),
                ),
                Icon(Icons.attach_money,
                color: const Color(0xFFFFD700),
                size: 15,),
                SizedBox(width: 2,),
                Text("3 125 FCFA",style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey
                ),)
              ],
            )
          ],
        ),
      )
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
