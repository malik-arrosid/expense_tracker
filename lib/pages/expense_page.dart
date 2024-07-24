import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:expense_tracker/pages/expense_detail_page.dart';
import 'package:expense_tracker/database/expense_database.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/pages/add_edit_expense_page.dart';
import 'package:expense_tracker/widgets/expense_card_widget.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  late List<Expense> _expenses;
  var _isLoading = false;

  Future<void> _refreshNotes() async {
    setState(() {
      _isLoading = true;
    });
    _expenses = await ExpenseDatabase.instance.getAllExpenses();
    _expenses.sort((a, b) {
      final amountA =
          int.tryParse(a.amount.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      final amountB =
          int.tryParse(b.amount.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      return amountB
          .compareTo(amountA); // Mengurutkan dari terbesar ke terkecil
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Expenses'),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddEditExpensePage()));
              _refreshNotes();
            }),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _expenses.isEmpty
                ? const Center(child: Text('Expense Empty'))
                : ListView.builder(
                    itemCount: _expenses.length,
                    itemBuilder: (context, index) {
                      final expense = _expenses[index];
                      return GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ExpenseDetailPage(id: expense.id!)));
                            _refreshNotes();
                          },
                          child: ExpenseCardWidget(
                              expense: expense, index: index));
                    }));
  }
}
