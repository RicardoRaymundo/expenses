import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.onRemove,
  }) : super(key: key);

  final Transaction transaction;
  final Function(String p1) onRemove;

  @override
  Widget build(BuildContext context) {
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
        subtitle: Text(DateFormat('d MMM y').format(transaction.date)),
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
  }
}
