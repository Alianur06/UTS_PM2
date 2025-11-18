// File: lib/main.dart
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart'; // Import file splash screen

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SAKTI',
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        primarySwatch: Colors.blue, 
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Set SplashScreen sebagai halaman pertama
      home: const SplashScreen(), 
    );
  }
}