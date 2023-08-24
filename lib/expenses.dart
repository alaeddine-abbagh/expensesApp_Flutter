import 'package:flutter/material.dart';
import 'package:expensesapp/models/expense.dart';
import 'package:expensesapp/widgets/expenses_list/expenses_list.dart';
import 'package:expensesapp/widgets/newExpense.dart';
import 'package:expensesapp/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registredExpenses = [
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

  void _addExpense(Expense expense) {
    setState(() {
      _registredExpenses.add(expense);
    });
  }

  void _deleteExpense(Expense expense) {
    final expenseIndex = _registredExpenses.indexOf(expense);
    setState(() {
      _registredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  void _openExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpenseState(onAddExpense: _addExpense),
    );
  }

  @override
  Widget build(BuildContext contect) {
    final width = MediaQuery.of(context).size.width;
    print(width);
    final height = MediaQuery.of(context).size.width;

    MediaQuery.of(context).size.height;

    Widget mainContent = const Center(
      child: Text("Feel free to add any expenses"),
    );
    if (_registredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
          expenseslist: _registredExpenses, onRemove: _deleteExpense);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registredExpenses),
                Expanded(child: mainContent),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registredExpenses)),
                Expanded(child: mainContent),
              ],
            ),
    );
  }
}
