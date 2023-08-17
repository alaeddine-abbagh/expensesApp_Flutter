import 'package:flutter/material.dart';
import '../../models/expense.dart';

class ExpenseItemStyle extends StatelessWidget {
  const ExpenseItemStyle({super.key, required this.expenseItem});
  final Expense expenseItem;

  @override
  Widget build(context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(children: [
          Text(expenseItem.title),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('\$${expenseItem.amount.toStringAsFixed(2)}'),
              Spacer(),
              Row(
                children: [
                  Icon(categoryIcons[expenseItem.category]),
                  const SizedBox(width: 8),
                  Text(expenseItem.formattedDate),
                ],
              ),
            ],
          )
        ]),
      ),
    );
  }
}
