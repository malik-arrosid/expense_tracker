import 'package:expense_tracker/pages/expense_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Expense Tracker',
      home: ExpensePage(),
    );
  }
}