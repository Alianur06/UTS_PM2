// File: lib/screens/splash_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import HomeScreen

// Warna SAKTI
const Color primaryColor = Color(0xFF0D47A1); 
const Color secondaryColor = Color(0xFFFFC107); 

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  
  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), 
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();

    // Navigasi ke HomeScreen setelah 3 detik
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor, // Latar belakang biru tua SAKTI
      body: Center(
        child: FadeTransition(
          opacity: _fade,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Placeholder Logo SAKTI
              const Icon(
                Icons.account_balance, 
                size: 80, 
                color: secondaryColor,
              ),
              const SizedBox(height: 20),
              const Text(
                'SAKTI',
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const Text(
                'SEPUTAR aktivitas berita terkini',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}