import 'package:flutter/material.dart';
import 'dart:async';

class MyLoadingPage extends StatefulWidget {
  const MyLoadingPage({super.key, required this.title});

  final String title;

  @override
  State<MyLoadingPage> createState() => _MyLoadingPageState();
}

class _MyLoadingPageState extends State<MyLoadingPage> {

  @override
  void initState() {
    super.initState();
    // 1. VOUS METTEZ LA DURÉE ICI (ex: 3 secondes)
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home'); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      body: Center(
        child: Image.asset('assets/images/splash.png'),
      ),
    );
  }
}
