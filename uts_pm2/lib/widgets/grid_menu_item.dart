import 'package:flutter/material.dart';

// Warna SAKTI
const Color primaryColor = Color(0xFF0D47A1); 

class GridMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor; 
  final VoidCallback? onTap; 

  const GridMenuItem({
    super.key,
    required this.icon,
    required this.label,
    required this.iconColor, 
    this.onTap, 
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), 
      ),
      child: InkWell(
        onTap: onTap, 
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(8.0), 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 60, 
                color: iconColor, 
              ),
              const SizedBox(height: 10),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor, 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}