import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text("Nema transakcija!",
                    style: Theme.of(context).textTheme.bodyText1),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    child: Image.asset(
                  'assets/fonts/images/waiting.png',
                  fit: BoxFit.cover,
                  height: 200,
                ))
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('${transactions[index].amount}KM'),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat('dd-MM-yyyy').format(transactions[index].date),
                    ),
                    trailing: IconButton(
                        onPressed: () => deleteTx(transactions[index].id),
                        icon: const Icon(Icons.delete),
                        color: Theme.of(context).errorColor),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}

/*Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "${transactions[index].amount.toStringAsFixed(2)} KM",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            transactions[index].title,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(
                            DateFormat('dd.MM.yyyy')
                                .format(transactions[index].date),
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )*/