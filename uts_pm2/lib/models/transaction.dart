class Transaction {
  final String title;
  final String category;
  final double amount;
  final DateTime date;
  final bool isIncome; 

  Transaction({
    required this.title,
    required this.category,
    required this.amount,
    required this.date,
    required this.isIncome,
  });
}