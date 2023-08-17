import 'package:expensesapp/widgets/expenses_list/expenseitemStyle.dart';
import 'package:flutter/material.dart';
import '../../models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenseslist});
  final List<Expense> expenseslist;

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: expenseslist.length,
      itemBuilder: (ctx, index) =>
          ExpenseItemStyle(expenseItem: expenseslist[index]),
    );
  }
}
