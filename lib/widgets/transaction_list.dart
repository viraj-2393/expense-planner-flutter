import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
class TransactionList extends StatelessWidget{
  final List<Transaction> _userTransactions;
  final Function _deleteTx;
  TransactionList(this._userTransactions,this._deleteTx);
   @override
  Widget build(BuildContext context) {
    return Container(
      //height: 400,
      width: double.infinity,
      child: _userTransactions.isEmpty ?
          Column(
            children: [
              Text('No transactions added yet!',style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 20.0,),
              Container(
                height: 200,
                child: Image.asset('assets/images/waiting.png',fit: BoxFit.cover,),
              )
            ],
          )
          :ListView.builder(
        itemBuilder: (ctx,index){
          return Card(
            child: Row(
              children: [
                Container(
                  width: 60,
                  decoration:BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor,width: 1),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  margin:EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                  padding: EdgeInsets.all(10.0),
                  child: FittedBox(
                         child: Text(
                           '\$ ${_userTransactions[index].amount.toStringAsFixed(2)}',
                           style: TextStyle(
                               color: Theme.of(context).primaryColor,
                               fontWeight: FontWeight.bold
                           ),
                         ),

                    )
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _userTransactions[index].title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      ),
                    ),
                    Text(
                      DateFormat().format(_userTransactions[index].date),
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13
                      ),
                    )
                  ],
                ),
                Expanded(child:SizedBox(height: 10,)),
                IconButton(onPressed: ()=>_deleteTx(_userTransactions[index].id), icon: Icon(Icons.delete,color: Theme.of(context).errorColor,)),

              ],
            ),
          );
        },
        itemCount: _userTransactions.length,
        //children: _userTransactions.map((transaction){

      )
      );
  }
}