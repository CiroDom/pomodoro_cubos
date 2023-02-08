import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counterMin = 25;
  int _counterSec = 59;
  late Timer _timerMin;
  late Timer _timerSec;
  String _minutes = '25';
  String _seconds = '00';

  void _regressiveCounter() {
     _timerMin = Timer.periodic(Duration(minutes: 1), (timer) {
         if(_counterMin == 0){
           _timerMin.cancel();
         }

         setState(() {
           _counterMin--;
         });
     });
     _timerSec = Timer.periodic(Duration(seconds: 1), (timer) {
       if(_counterSec == 0) {
        setState(() {
          _counterSec = 59;
        });
       }
       else {
         setState(() {
           _counterSec--;
         });
       }
     });

     if(_counterMin == 0 && _counterSec == 0) {
       _timerSec.cancel();
     }

     if(_counterMin < 10) {
       setState(() {
         _minutes = "0$_counterMin";
       });
     }
     else {
       setState(() {
         _minutes = "$_counterMin";
       });
     }

     if(_counterSec < 10) {
       setState(() {
         _seconds = '0$_counterSec';
       });
     }
     else {
       setState(() {
         _seconds = "$_counterSec";
       });
     }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Contagem regressiva',
            ),
            Text(
              '$_minutes : $_seconds',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _regressiveCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
