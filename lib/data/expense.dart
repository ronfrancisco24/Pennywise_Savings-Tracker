// models/expense.dart
class Expense {
  final String id; // Unique identifier
  final String product;
  final double price;

  Expense({required this.id, required this.product, required this.price});
}