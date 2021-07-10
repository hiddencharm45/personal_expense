import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime selectDate;
  void submitData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectDate == null) {
      return; //Also stops function execution
    }
    widget.addTx(
      //widget. is used to use properties of widget class inside state class
      enteredTitle,
      enteredAmount,
      selectDate,
    ); //double.parser would make sure to convert string to double as amount is double in add transaction method
    Navigator.of(context).pop(); //close the screen when enter is pressed
  }

  void presentDatePicker() {
    showDatePicker(
      //inbuilt flutter fn, return null if nothing is choosen
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickeddate) {
      if (pickeddate == null) {
        return;
      }
      setState(() {
        selectDate = pickeddate;
      });
    }); //flutter show automatically //context on left is datepicker argument and context on right is a class property set by us
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      //to make typing part scorllable so we dont have to close keyboard, not great solution but would do
      child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: titleController,
                  onSubmitted: (_) => submitData(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) =>
                      submitData(), //annonymous and argument add here not main function passing pointer to fn
                  //_ used maeans I gave argument but I won't use it
                ),
                //To make user select custum dates, to avoid hussle and also flexibilty to choose dates
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          selectDate == null
                              ? 'No Date Chosen!'
                              : ('Picked Date: ${DateFormat.yMd().format(selectDate)}'),
                        ),
                      ),
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        onPressed: presentDatePicker,
                        child: Text(
                          'Choose date',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  textColor: Theme.of(context).textTheme.button.color,
                  color: Theme.of(context).accentColor,
                  onPressed: submitData,
                  child: Text('Add Transaction'),
                ),
              ],
            ),
          )),
    );
  }
}
