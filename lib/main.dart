import 'package:flutter/material.dart';
//import 'package:flutter/services.dart' ; to manafe features like locking screen orientation
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPrefferedOrientations([
  //DeviceOrientation.portraitUp,
  //DeviceOrientation.portraitDown, to manage orientation
  //]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.brown,
          //It is an alternative color accentColor-when we wanna mix colors
          accentColor: Colors.blueGrey,
          //errorColor: By default
          fontFamily: 'QuickSand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                button: TextStyle(color: Colors.white),
              ),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ))),
      title:
          'Personal Expenses', //This title shown in background mode, task manager
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    //Transaction(
    //id: 't1',
    //title: 'New Shows',
    //amount: 45.6,
    //date: DateTime.now(),
    //),
    //Transaction(
    //id: 't2',
    //title: 'New whatever',
    //amount: 47.6,
    //date: DateTime.now(),
    //),
    //Transaction(
    //id: 't3',
    //title: 'hmmmmm',
    //amount: 666.6,
    //date: DateTime.now(),
    //),
  ];
  bool _showChart = false;
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txtitle, double txamount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txtitle,
      amount: txamount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(
          newTx); //this way final valriable not re-instated but we manipulate the data
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    //Wil show input area of new transaction area
    //Build context is passed which wil take build context from already builder scaffold n body down
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          /*....Gesture detector used so that when modal tapped it 
          doesnt closes only on background tap it closes but
          in this flutter it's automatic I wrote it just for the sake of learning.
          code:
          return GestureDetector(
            child: NewTxn(_addNT),
            onTap:something,
            behavior:Something,
          )
          */
          return NewTransaction(_addNewTransaction);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //create appbar as variable that can be used
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      //backgroundColor: Colors.purple,
      title: Text(
        'Personal Expense',
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );
    final txListWidget = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: TransactionList(_userTransactions, _deleteTransaction));
    return Scaffold(
      appBar: appBar, //using the variable made in which I stored the widget
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart'),
                  Switch(
                    value: _showChart, //reflected by what the user choose
                    onChanged: (val) {
                      setState(
                        () {
                          _showChart = val;
                        },
                      );
                    },
                  ),
                ],
              ),
            if (!isLandscape)
              Container(
                //ternety exp to either show chart or a list on press of show chart toggle
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(_recentTransactions),
              ),
            if (!isLandscape) txListWidget,
            if (isLandscape)
              _showChart
                  ? Container(
                      //ternety exp to either show chart or a list on press of show chart toggle
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: Chart(_recentTransactions),
                    )
                  : txListWidget //container stored in the variable
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
