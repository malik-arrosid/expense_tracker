import 'package:flutter/material.dart';

class ExpenseFormWidget extends StatelessWidget {
  const ExpenseFormWidget(
      {super.key,
      required this.amount,
      required this.paymentMethod,
      required this.category,
      required this.items,
      required this.onChangeAmount,
      required this.onChangePaymentMethod,
      required this.onChangeCategory,
      required this.onChangeItems});

  final String amount;
  final String paymentMethod;
  final String category;
  final String items;
  final ValueChanged<String> onChangeAmount;
  final ValueChanged<String> onChangePaymentMethod;
  final ValueChanged<String> onChangeCategory;
  final ValueChanged<String> onChangeItems;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _amountField(),
            const SizedBox(
              height: 8,
            ),
            _paymentMethodField(),
            const SizedBox(
              height: 8,
            ),
            _categoryField(),
            const SizedBox(
              height: 8,
            ),
            _itemsField(),
          ],
        ),
      ),
    );
  }

  Widget _amountField() {
    return TextFormField(
      maxLines: 1,
      initialValue: amount,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
        labelText: 'Amount',
        labelStyle: TextStyle(fontSize: 20, color: Colors.black),
      ),
      onChanged: onChangeAmount,
      validator: (amount) {
        return amount != null && amount.isEmpty
            ? 'The amount cannot be empty'
            : null;
      },
    );
  }

  Widget _paymentMethodField() {
    return TextFormField(
      maxLines: 1,
      initialValue: paymentMethod,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
        labelText: 'Payment Method',
        labelStyle: TextStyle(fontSize: 20, color: Colors.black),
      ),
      onChanged: onChangePaymentMethod,
      validator: (paymentMethod) {
        return paymentMethod != null && paymentMethod.isEmpty ? 'The payment method cannot be empty' : null;
      },
    );
  }

  Widget _categoryField() {
    return TextFormField(
      maxLines: 1,
      initialValue: category,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
        labelText: 'Category',
        labelStyle: TextStyle(fontSize: 20, color: Colors.black),
      ),
      onChanged: onChangeCategory,
      validator: (category) {
        return category != null && category.isEmpty ? 'The category cannot be empty' : null;
      },
    );
  }

  Widget _itemsField() {
    return TextFormField(
      maxLines: 1,
      initialValue: items,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
        labelText: 'Items',
        labelStyle: TextStyle(fontSize: 20, color: Colors.black),
      ),
      onChanged: onChangeItems,
      validator: (items) {
        return items != null && items.isEmpty ? 'The items cannot be empty' : null;
      },
    );
  }
}