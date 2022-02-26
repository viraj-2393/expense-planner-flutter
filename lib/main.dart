import 'dart:io';
import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import 'package:flutter/services.dart';

void main(){
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown
  // ]);
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
    Transaction(id: 't2', title: 'Node.js Course', amount: 5.00, date: DateTime.now()),
    Transaction(id: 't3', title: 'Flutter Course', amount: 4.9, date: DateTime.now()),
    Transaction(id: 't4', title: 'Node.js Course', amount: 5.00, date: DateTime.now()),
    Transaction(id: 't5', title: 'Flutter Course', amount: 4.9, date: DateTime.now()),
    Transaction(id: 't6', title: 'Node.js Course', amount: 5.00, date: DateTime.now()),
    Transaction(id: 't7', title: 'Flutter Course', amount: 4.9, date: DateTime.now()),
    Transaction(id: 't8', title: 'Node.js Course', amount: 5.00, date: DateTime.now())
  ];

  bool _showChart = false;

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
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('Expense Planner'),
      actions: [
        IconButton(
            onPressed: ()=> _startAddNewTransaction(context),
            icon: Icon(Icons.add))
      ],
      centerTitle: true,
    );
    final txListWidget = Container(
      height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );
    return Scaffold(
      appBar: appBar,
      body:SingleChildScrollView(
        child: Column(
          children: [
            if(isLandscape) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show Chart'),
                Switch.adaptive(
                  onChanged: (val){
                    setState(() {
                      _showChart = val;
                    });
                  },
                  value: _showChart,
                )
              ],
            ),
            if(!isLandscape) Container(
              height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.3 ,
              child: Chart(_recentTransactions),
            ) ,
            if(!isLandscape) txListWidget,
            if(isLandscape)
            _showChart ? Container(
              height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.7 ,
              child: Chart(_recentTransactions),
            ) :
            txListWidget,

            //UserTransactions(),
            //Expanded(child: TransactionList(_userTransactions,_deleteTransaction))
          ],
        ),
      ) ,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS?Container():FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );

  }
}