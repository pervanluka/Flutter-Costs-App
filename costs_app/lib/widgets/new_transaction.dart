import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitDate() {
    if(_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Naslov'),
              controller: _titleController,
              onSubmitted: (_) => _submitDate(),
              // onChanged: (val) => titleInput = val,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Cijena'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitDate(),
              // onChanged: (value) => amountInput = value,
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? "Nije izabran datum"
                          : DateFormat("dd-MM-yyyy").format(_selectedDate!),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        primary: ThemeData.light().primaryColor),
                    onPressed: _presentDatePicker,
                    child: const Text(
                      'Izaberi datum',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              child: const Text('Dodaj transakciju'),
              style: TextButton.styleFrom(
                  primary: Color.fromARGB(255, 255, 255, 255)),
              onPressed: _submitDate,
            )
          ],
        ),
      ),
    );
  }
}
