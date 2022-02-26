import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NewTransaction extends StatefulWidget{
  final Function addTransaction;
  NewTransaction(this.addTransaction);
  @override
  State<StatefulWidget> createState() {
    return _NewTransactionState();
  }
}
class _NewTransactionState extends State<NewTransaction>{
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  late DateTime _selectedDate = DateTime.now();

  void submitData(){
    if(amountController.text.isEmpty){
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if(enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null){
      return;
    }
    widget.addTransaction(enteredTitle,enteredAmount,_selectedDate);
    Navigator.of(context).pop();
  }
  void _presentDatePicker(){
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2019), lastDate: DateTime.now()).
    then((pickedDate){
      if(pickedDate == null){
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });

    });
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Card(
        elevation: 5,
        child:Container(
          padding: EdgeInsets.only(top:10,left:10,right:10,bottom:MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: titleController,
                onSubmitted: (_) => submitData(),
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
                decoration: InputDecoration(
                    labelText: 'Amount'
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _selectedDate == null ? Text('No date chosen!') : Text('Picked date: ${DateFormat.yMd().format(_selectedDate)}'),
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: Text('Choose Date',style: TextStyle(fontWeight: FontWeight.bold),),
                  )
                ],
              ),
              TextButton(
                onPressed: submitData,
                child: Text('Add Transaction',style: TextStyle(fontWeight: FontWeight.bold),),
              )
            ],
          ),
        ),

      ) ,
    );
  }
}