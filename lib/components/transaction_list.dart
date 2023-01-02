import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(
      {super.key, required this.transactions, required this.onRemove});

  final List<Transaction> transactions;
  final Function(String) onRemove;
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Nenhuma transação cadastrada',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: ((context, index) {
              final transaction = transactions[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                        child: Text(
                          'R\$${transaction.value}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transaction.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle:
                      Text(DateFormat('d MMM y').format(transaction.date)),
                  trailing: MediaQuery.of(context).size.width > 480
                      ? TextButton.icon(
                          onPressed: () => onRemove(transaction.id),
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).errorColor,
                          ),
                          label: Text(
                            'Excluir',
                            style: TextStyle(
                              color: Theme.of(context).errorColor,
                            ),
                          ),
                        )
                      : IconButton(
                          icon: const Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => onRemove(transaction.id),
                        ),
                ),
              );
            }),
          );
  }
}
