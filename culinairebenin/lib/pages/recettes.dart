import 'package:flutter/material.dart';

class RecettePage extends StatefulWidget {
  const RecettePage ({super.key});

  @override
  State<RecettePage> createState() => _RecetteStatePage();

}

class _RecetteStatePage extends State<RecettePage>  {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Recettes"),
      ),
    );
  }

}