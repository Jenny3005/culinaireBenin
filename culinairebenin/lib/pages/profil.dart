import 'package:flutter/material.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage ({super.key});

  @override
  State<ProfilPage> createState() => _ProfilStatePage();

}

class _ProfilStatePage extends State<ProfilPage>  {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Profil"),
      ),
    );
  }

}