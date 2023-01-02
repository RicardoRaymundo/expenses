// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:math';
import 'dart:io';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    final themeData = ThemeData();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: themeData.copyWith(
        colorScheme: themeData.colorScheme
            .copyWith(primary: Colors.purple, secondary: Colors.amber),
        textTheme: themeData.textTheme.copyWith(
          button: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't0',
      title: 'Conta antiga',
      value: 400.76,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't1',
      title: 'Novo Tenis de corrida',
      value: 310.76,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 't2',
      title: 'Roupinha para o Belo',
      value: 250.2,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 't3',
      title: 'Cartão de crédito',
      value: 150.2,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
    Transaction(
      id: 't4',
      title: 'Jantar com mozao',
      value: 50.2,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't5',
      title: 'Nata com mozao',
      value: 100.2,
      date: DateTime.now().subtract(Duration(days: 6)),
    ),
    Transaction(
      id: 't6',
      title: 'Breja com mozao',
      value: 40.2,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 't7',
      title: 'BK com mozao',
      value: 70.2,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );
    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  void _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  Widget _getIconButton(IconData icon, Function() fn) {
    return Platform.isIOS
        ? GestureDetector(
            onTap: fn,
            child: Icon(icon),
          )
        : IconButton(
            icon: Icon(icon),
            onPressed: fn,
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    bool isLandScape = mediaQuery.orientation == Orientation.landscape;

    final iconList = Platform.isIOS ? CupertinoIcons.refresh : Icons.list;
    final iconChart =
        Platform.isIOS ? CupertinoIcons.refresh : Icons.show_chart;

    final actions = [
      if (isLandScape)
        _getIconButton(
          _showChart ? iconList : iconChart,
          () {
            setState(() {
              _showChart = !_showChart;
            });
          },
        ),
      SizedBox(
        width: 20,
      ),
      _getIconButton(
        Platform.isIOS ? CupertinoIcons.add : Icons.add,
        () => _openTransactionFormModal(context),
      ),
    ];

    final AppBar appBar = AppBar(
      title: Text('Despesas Pessoais'),
      actions: actions,
    );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final page = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_showChart || !isLandScape)
              SizedBox(
                  height: availableHeight * (isLandScape ? 0.8 : 0.3),
                  child: Chart(_recentTransactions)),
            if (!_showChart || !isLandScape)
              SizedBox(
                height: availableHeight * (isLandScape ? 1 : 0.7),
                child: TransactionList(
                    transactions: _transactions, onRemove: _deleteTransaction),
              )
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text('Despesas Pessoais'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ),
            ),
            child: page,
          )
        : Scaffold(
            appBar: appBar,
            body: page,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? SizedBox()
                : FloatingActionButton(
                    onPressed: () => _openTransactionFormModal(context),
                    child: Icon(Icons.add),
                  ),
          );
  }
}
