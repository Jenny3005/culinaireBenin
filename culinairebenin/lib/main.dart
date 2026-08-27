import 'package:culinairebenin/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:culinairebenin/pages/home_page.dart';
import 'package:culinairebenin/pages/login.dart';
import 'package:culinairebenin/pages/register.dart';
import 'package:culinairebenin/pages/profil.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trésors Culinaires du Bénin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(235, 65, 18, 1),
        ),
      ),
      home: const MyLoadingPage(title: 'Loading...'),

      initialRoute: '/',
      routes: {
        '/home': (context) => const MyHomePage(),
        '/register': (context) => const RegisterPage(),
        '/login': (context) => const LoginPage(),
        '/profil' :(context) => const ProfilPage(),
      },
    );
  }
}
