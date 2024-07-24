import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseCardWidget extends StatelessWidget {
  const ExpenseCardWidget(
      {super.key, required this.expense, required this.index});

  final Expense expense;
  final int index;

  @override
  Widget build(BuildContext context) {
    final time = DateFormat.yMMMd().add_jms().format(expense.createdTime);
    // final minHeight = _getMinHeight(index);
    final color = _getColorForExpense(expense.amount);

    return Card(
      color: color,
      child: Container(
        // constraints: BoxConstraints(minHeight: minHeight),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: TextStyle(color: Colors.grey.shade700),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              'IDR ${expense.amount}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              expense.category,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // double _getMinHeight(int index) {
  //   switch (index % 4) {
  //     case 0:
  //     case 3:
  //       return 100;
  //     case 1:
  //     case 2:
  //       return 150;
  //     default:
  //       return 100;
  //   }
  // }

  Color _getColorForExpense(String amountString) {
    final amount = int.tryParse(amountString.replaceAll(RegExp(r'[^0-9]'), ''));
    if (amount == null) {
      return Colors.grey; // Or any default color for invalid amounts
    }

    if (amount >= 600000) {
      return Colors.red;
    } else if (amount >= 100000) {
      return const Color(0xFFEA8BA1);
    } else if (amount >= 50000) {
      return const Color(0xFF77BAE3);
    } else if (amount >= 20000) {
      return const Color(0xFF76D79F);
    } else if (amount >= 10000) {
      return const Color(0xFFAB97D0);
    } else if (amount >= 5000) {
      return const Color(0xFFF6B884);
    } else if (amount >= 2000) {
      return const Color(0xFFA1B0C1);
    } else {
      return const Color(0xFFC9C56F);
    }
  }
}