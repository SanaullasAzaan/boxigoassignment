import 'package:boxigoapp/mainlayout.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Main app structure
class MyApp extends StatelessWidget {
  const MyApp ({super.key});
  @override
  Widget build(BuildContext context) {
    return const  MaterialApp(
      home: MainLayout(),  // Main layout that contains the app structur
       debugShowCheckedModeBanner: false,
    );
  }
}