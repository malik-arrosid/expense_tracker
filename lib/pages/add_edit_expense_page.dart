import 'package:expense_tracker/widgets/expense_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/database/expense_database.dart';

class AddEditExpensePage extends StatefulWidget {
  const AddEditExpensePage({super.key, this.expense});
  final Expense? expense;

  @override
  State<AddEditExpensePage> createState() => _AddEditExpensePageState();
}

class _AddEditExpensePageState extends State<AddEditExpensePage> {
  late String _amount;
  late String _paymentMethod;
  late String _category;
  late String _items;
  final _formKey = GlobalKey<FormState>();
  var _isUpdateForm = false;

  @override
  void initState() {
    super.initState();
    _amount = widget.expense?.amount ?? '';
    _paymentMethod = widget.expense?.paymentMethod ?? '';
    _category = widget.expense?.category ?? '';
    _items = widget.expense?.items ?? '';
    _isUpdateForm = widget.expense != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isUpdateForm ? 'Edit' : 'Add' ),
        actions: [
          _buttonSave(),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ExpenseFormWidget(
          amount: _amount, 
          paymentMethod: _paymentMethod, 
          category: _category, 
          items: _items, 
          onChangeAmount: (value) {
            setState(() {
              _amount = value;
            });
          }, 
          onChangePaymentMethod: (value) {
            setState(() {
              _paymentMethod = value;
            });
          }, 
          onChangeCategory: (value) {
            _category = value;
          }, 
          onChangeItems: (value) {
            _items = value;
          },
        ),
      ),
    );
  }

  Widget _buttonSave() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(onPressed: () async {
        final isValid = _formKey.currentState!.validate();
        if(isValid) {
          if(_isUpdateForm) {
            await _updateExpense();
          } else {
            await _addExpense();
          }
          Navigator.pop(context);
        }
      }, child: const Text('Save')),
    );
  }

  Future<void> _addExpense() async {
    final expense = Expense(
      amount: _amount,
      paymentMethod: _paymentMethod,
      category: _category,
      items: _items,
      createdTime: DateTime.now()
    );
    await ExpenseDatabase.instance.create(expense);
  }

  Future<void> _updateExpense() async {
    final updateExpense = Expense(
      id: widget.expense?.id,
      amount: _amount,
      paymentMethod: _paymentMethod,
      category: _category,
      items: _items,
      createdTime: DateTime.now()
    );
    await ExpenseDatabase.instance.updateExpense(updateExpense);
  }
}
