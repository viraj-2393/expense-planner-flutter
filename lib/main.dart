import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
void main(){
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.deepOrange,
      fontFamily: 'Quicksand',
    ),
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }

}
class _HomeState extends State<Home>{
  final List<Transaction> _userTransactions = [
    Transaction(id: 't1', title: 'Flutter Course', amount: 4.9, date: DateTime.now()),
    Transaction(id: 't2', title: 'Node.js Course', amount: 5.00, date: DateTime.now())
  ];
  List<Transaction> get _recentTransactions{
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }
  void _addNewTransaction(String txTitle,double txAmount,DateTime dateTime){
    final newTx = Transaction(id: DateTime.now().toString(), title: txTitle, amount: txAmount, date: dateTime);
    setState(() {
      _userTransactions.add(newTx);
    });
  }
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: (){},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }
  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((element) {
        return element.id == id;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Planner'),
        actions: [
          IconButton(
              onPressed: ()=> _startAddNewTransaction(context),
              icon: Icon(Icons.add))
        ],
        centerTitle: true,
      ),
      body:Column(
          children: [
            Chart(_recentTransactions),
            //UserTransactions(),
            Expanded(child: TransactionList(_userTransactions,_deleteTransaction))


          ],
        ) ,
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );

  }
}