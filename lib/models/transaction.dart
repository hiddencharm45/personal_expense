//Not a widget, it's a simple object model
import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date; //built in object of dart

  Transaction(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.date});
}
//kkk
