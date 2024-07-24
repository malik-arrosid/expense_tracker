const String tableExpenses = 'expenses';

class ExpenseFields {
  static const String id = 'id';
  static const String amount = 'amount';
  static const String paymentMethod = 'payment_method';
  static const String category = 'category';
  static const String items = 'items';
  static const String time = 'time';
}

class Expense {
  final int? id;
  final String amount;
  final String paymentMethod;
  final String category;
  final String items;
  final DateTime createdTime;

  Expense(
      {this.id,
      required this.amount,
      required this.paymentMethod,
      required this.category,
      required this.items,
      required this.createdTime});

  Expense copy(
      {int? id,
      String? amount,
      String? paymentMethod,
      String? category,
      String? items,
      DateTime? createdTime}) {
    return Expense(
        id: id,
        amount: amount ?? this.amount,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        category: category ?? this.category,
        items: items ?? this.items,
        createdTime: createdTime ?? this.createdTime);
  }

  static Expense fromJson(Map<String, Object?> json) {
    return Expense(
      id: json[ExpenseFields.id] as int?,
      amount: json[ExpenseFields.amount] as String,
      paymentMethod: json[ExpenseFields.paymentMethod] as String,
      category: json[ExpenseFields.category] as String,
      items: json[ExpenseFields.items] as String,
      createdTime: DateTime.parse(json[ExpenseFields.time] as String),
    );
  }

  Map<String, Object?> toJson() => {
        ExpenseFields.id: id,
        ExpenseFields.amount: amount,
        ExpenseFields.paymentMethod: paymentMethod,
        ExpenseFields.category: category,
        ExpenseFields.items: items,
        ExpenseFields.time: createdTime.toIso8601String(),
      };
}
