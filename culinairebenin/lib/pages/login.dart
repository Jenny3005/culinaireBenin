import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column (
        children: [
          Container (
            height: 200,
            color: Colors.brown,
            child: Center (
              child :Column (
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png', width: 100, height: 100),
                  Text('Trésors Culinaires du Bénin', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))
                ],
              )
            )
          ),
          Expanded (
            child: Container (
              color: Colors.white,
            )
          )
        ]
      )
    );
  }
}