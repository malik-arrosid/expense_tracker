import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/database/expense_database.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/pages/add_edit_expense_page.dart';

class ExpenseDetailPage extends StatefulWidget {
  const ExpenseDetailPage({super.key, required this.id});
  final int id;

  @override
  State<ExpenseDetailPage> createState() => _ExpenseDetailPageState();
}

class _ExpenseDetailPageState extends State<ExpenseDetailPage> {
  late Expense _expense;
  var _isLoading = false;

  Future<void> _refreshNote() async {
    setState(() {
      _isLoading = true;
    });
    _expense = await ExpenseDatabase.instance.getExpenseById(widget.id);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshNote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Page'),
          actions: [
            _editButton(),
            _deleteButton(),
          ],
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                padding: const EdgeInsets.all(8),
                children: [
                  Text(
                    _expense.amount,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    _expense.paymentMethod,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(DateFormat.yMMMd().format(_expense.createdTime)),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    _expense.category,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    _expense.items,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ));
  }

  Widget _editButton() {
    return IconButton(
        onPressed: () async {
          if (_isLoading) return;
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddEditExpensePage(
                  expense: _expense,
                ),
              ));
          _refreshNote();
        },
        icon: const Icon(Icons.edit));
  }

  Widget _deleteButton() {
    return IconButton(
        onPressed: () async {
          if (_isLoading) return;
          await ExpenseDatabase.instance.deleteExpenseById(widget.id);
          Navigator.pop(context);
        },
        icon: const Icon(Icons.delete));
  }
}
