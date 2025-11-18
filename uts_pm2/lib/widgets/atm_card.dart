// File: lib/widgets/atm_card.dart

import 'package:flutter/material.dart';

// Warna SAKTI
const Color primaryColor = Color(0xFF0D47A1);
const Color secondaryColor = Color(0xFFFFC107);

class AtmCard extends StatelessWidget {
  final double currentBalance;

  // Pastikan ini non-const jika menggunakan properti non-const di dalamnya
  const AtmCard({super.key, required this.currentBalance}); 

  @override
  Widget build(BuildContext context) {
    return Container(
      // TIDAK ADA margin NEGATIF DI SINI
      padding: const EdgeInsets.all(25), 
      width: double.infinity,
      decoration: BoxDecoration(
        color: primaryColor, 
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            // Mengganti withOpacity yang deprecated:
            color: Colors.black.withAlpha(77), 
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Baris 1: Chip & Logo Bank Placeholder
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Menggunakan ikon yang pasti ada
              const Icon(Icons.credit_card, color: secondaryColor, size: 30), 
              const Text('SAKTI Bank', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), 
            ],
          ),
          const SizedBox(height: 30),

          // Baris 2: Judul Saldo
          const Text(
            'Total Saldo',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 5),

          // Baris 3: Nilai Saldo
          Text(
            'Rp ${currentBalance.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          // Baris 4: Nomor Kartu Placeholder
          const Text(
            '**** **** **** 4321',
            style: TextStyle(color: Colors.white70, fontSize: 18, letterSpacing: 2),
          ),
        ],
      ),
    );
  }
}