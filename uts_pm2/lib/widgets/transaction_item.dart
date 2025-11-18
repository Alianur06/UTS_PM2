import 'package:flutter/material.dart';
// PASTIKAN JALUR INI BENAR:
import '../models/transaction.dart'; // Menggunakan nama class 'Transaction'

class TransactionItem extends StatelessWidget {
  // PERBAIKAN: Menggunakan class 'Transaction' yang sudah didefinisikan
  final Transaction transaction; 

  const TransactionItem({super.key, required this.transaction});

  // Fungsi helper untuk mendapatkan ikon berdasarkan kategori/status
  IconData _getIconData() {
    if (transaction.isIncome) {
      return Icons.arrow_upward;
    }
    // Ikon berdasarkan kategori (Jika ada)
    switch (transaction.category) {
      case 'Makanan':
        return Icons.fastfood;
      case 'Transportasi':
        return Icons.directions_car;
      case 'Tagihan':
        return Icons.receipt_long;
      default:
        return Icons.money_off;
    }
  }

  // Fungsi helper untuk mendapatkan warna berdasarkan status
  Color _getColor() {
    return transaction.isIncome ? Colors.green : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Bagian Kiri: Ikon dan Detail
          Row(
            children: [
              // Ikon Kategori
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  // PERBAIKAN: Mengganti withOpacity dengan withAlpha atau withOpacity
                  // Pada kasus ini, withOpacity masih aman karena diterapkan pada Color yang bukan const
                  color: _getColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(_getIconData(), color: _getColor()),
              ),
              const SizedBox(width: 15),
              
              // Judul dan Kategori
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${transaction.category} - ${transaction.date.day}/${transaction.date.month}',
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),

          // Bagian Kanan: Jumlah Nominal
          Text(
            '${transaction.isIncome ? '+' : '-'} Rp ${transaction.amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
            style: TextStyle(
              color: _getColor(),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}