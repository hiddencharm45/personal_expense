import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './chart_bar.dart';
import 'package:intl/intl.dart'; //used for getting week day names

class Chart extends StatelessWidget {
  //To get all list items
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);
  //adding getter method
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      //calculation of weekday, substraction done
      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      //print(DateFormat.E(weekDay)); #for checking lists
      //print(totalSum);
      return {
        'day': DateFormat.E().format(weekDay).substring(
            0, 1), //gives shortcut for weekdays, M for monday and all
        'amount': totalSum,
      }; //now as we manually calculate it chart would need a list of transactions that we have
    }).reversed.toList(); //reverse gives it in particualr order
  }

  //Another getter to calculate total spending of the week
  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    }); //fold allows to change list to other type to logic by function passed first arg passed
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              //Default is every item has same space
              //flex: 2, distribute the available space in row n clm btwn children
              fit: FlexFit
                  .tight, //used to force a child into it's assigned width and assigned size
              child: ChartBar(
                  data['day'],
                  data['amount'],
                  totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending),
            ); //As double because date is a string obj
          }).toList(),
        ),
      ),
    );
  }
}
