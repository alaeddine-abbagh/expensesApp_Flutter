import 'package:flutter/material.dart';
import 'package:expensesapp/models/expense.dart';
import 'package:expensesapp/widgets/expenses_list/expenses_list.dart';
import 'package:expensesapp/widgets/newExpense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  @override
  Widget build(BuildContext contect) {
    final List<Expense> registredExpenses = [
      Expense(
          title: 'Flutter course',
          amount: 20,
          date: DateTime.now(),
          category: Category.work),
      Expense(
          title: 'Udemy',
          amount: 19.5,
          date: DateTime.now(),
          category: Category.leisure)
    ];

    void _openExpenseOverlay() {
      setState(() {
        showModalBottomSheet(
          context: context,
          builder: (ctx) =>
              NewExpenseState(registredExpenses: registredExpenses),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          const Text('The chart'),
          Expanded(child: ExpensesList(expenseslist: registredExpenses)),
        ],
      ),
    );
  }
}
