import 'package:expensesapp/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpenseState extends StatefulWidget {
  const NewExpenseState({required this.registredExpenses, super.key});
  final List<Expense> registredExpenses;
  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpenseState> {
  var textController = TextEditingController();
  var costController = TextEditingController();
  Category _selectedCategory = Category.leisure;
  DateTime? _selectedDate;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    textController.dispose();
    costController.dispose();
    super.dispose();
  }

  void _submitSelectedExpense() {
    final amount = double.tryParse(costController.text);
    final amountIsValid = amount == null || amount <= 0;

    if (amountIsValid ||
        textController.text.trim().isEmpty ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid Input'),
          content: const Text(
              'Please make sure a valid Date, cost and title was entered'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    final newexpense = Expense(
        title: textController.text.trim(),
        amount: double.tryParse(costController.text)!,
        date: _selectedDate!,
        category: _selectedCategory);
    widget.registredExpenses.add(newexpense);
    print(widget.registredExpenses.length);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: textController,
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text("title"),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: costController,
                    maxLength: 8,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixText: '\$ ',
                      label: Text("cost"),
                    ),
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                        ? 'No date selected'
                        : formatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: Icon(Icons.calendar_month),
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat.name.toUpperCase()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      if (value == null) {
                        return;
                      }
                      _selectedCategory = value;
                    });
                  },
                ),
                Spacer(),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
                ElevatedButton(
                  onPressed: _submitSelectedExpense,
                  child: Text("Save expense"),
                ),
              ],
            ),
          ],
        ));
  }
}
