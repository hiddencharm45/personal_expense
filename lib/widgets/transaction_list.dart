import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  //Another method of listview in comments downwards for comaparison purpose
  @override

  //This is the method best suited for the very long list
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text('No Transactions Added Yet',
                    style: Theme.of(context).textTheme.headline6),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    //it could be wrapped inside a container for fixed height, if img not displayed properly
                    'assets/images/img.png',
                    fit: BoxFit.cover,
                  ),
                ), //Must be added in pubspec.yaml
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              //Removed code from here
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: FittedBox(
                            child: Text('\$${transactions[index].amount}')),
                      )),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                          textColor: Theme.of(context).errorColor,
                          onPressed: () => deleteTx(transactions[index].id),
                        )
                      : IconButton(
                          //used to add delete icon
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => deleteTx(transactions[index]
                              .id), //as it needs an argument so created an anonymous function
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}

/*This is normal listview method used
 
  @override
  Widget build(BuildContext context) {
    return Container(//if container removed no transaction would be showed
      height: 300,
      child: ListView(
        children: transactions.map((tx) {
          return Card(
              child: Row(children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              decoration: BoxDecoration(
                  border: Border.all(
                color: Colors.purple,
                width: 2,
              )),
              child: Text(
                '\$ ${tx.amount}', //String interpolation syntax special,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.purple,
                ), //used in conjusction with text widget
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      tx.title.toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      //or DateFormat('yyyy-MM-dd').format(tx.date),
                      DateFormat.yMMMd().format(tx.date),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
            )
          ]));
        }).toList(),
      ),
    );
  }
}
*/
/*
 Previous Code fully running 2nd attempt at list view 
 it's exchanged with other widhet called listtitle and circle avatar
-------------------------
return Card(
                    child: Row(children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    )),
                    child: Text(
                      //replcaing tx with transactions[index] because now map transactions isn't being called
                      '\$ ${transactions[index].amount.toStringAsFixed(2)}', //String interpolation syntax special,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                      ), //used in conjusction with text widget
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            transactions[index].title.toString(),
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            //or DateFormat('yyyy-MM-dd').format(tx.date),
                            DateFormat.yMMMd().format(transactions[index].date),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ]));
 */
