
import 'dart:async';

import 'package:flutter/material.dart';

class AppView extends StatefulWidget {
  const AppView({super.key, required this.title});

  final String title;

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {

  int _counterMin = 24;
  int _counterSec = 59;
  late Timer _timerMin;
  late Timer _timerSec;
  String _minutes = '25';
  String _seconds = '00';
  bool _isCountingActv = false;

  void _regressiveCounter() {
    _isCountingActv = true;

    _timerMin = Timer.periodic(const Duration(minutes: 1), (timer) {
      if(_counterMin == 0){
        _timerMin.cancel();
      }

      _counterMin--;

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
    });

    _timerSec = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(_counterMin == 0 && _counterSec == 0) {
        _timerSec.cancel();
      }
      else if(_counterSec == 0) {
        _counterSec = 59;
      }
      else {
        _counterSec--;
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
    });
  }

  void _restartCounter() {
    _isCountingActv = false;

    _timerMin.cancel();
    _timerSec.cancel();

    _counterMin = 24;
    _counterSec = 59;
    setState(() => _minutes = _counterMin.toString());
    setState(() => _seconds = _counterSec.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
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
            ElevatedButton(
              onPressed: _isCountingActv ? null : _regressiveCounter,
              child: const Text("Começar"),
            ),
            ElevatedButton(
              onPressed: _isCountingActv ? _restartCounter : null,
              child: const Text("Voltar"),
            )
          ],
        ),
      ),
    );
  }
}
