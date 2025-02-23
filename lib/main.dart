import 'package:flutter/material.dart';
import 'package:flutter_grocery_app/features/home/ui/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.teal
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}