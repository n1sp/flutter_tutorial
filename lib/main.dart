import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'タイマー'),
    );
  }
}

class CustomButton extends StatelessWidget {
  // コンストラクタ
  const CustomButton({
    this.text,
    this.width,
    this.height,
    this.onPressed,
    Key key,
  }) : super(key: key);

  final VoidCallback onPressed;
  final double width;
  final double height;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: Colors.white70,
            onPrimary: Colors.white,
          ),
          child: Text(
            text,
            style: TextStyle(color: Colors.black),
          ),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _time = '00:00';
  String _start = 'START';

  void _numberPressed(String number) {
    setState(() {
      if (_start == 'START') {
        int len = _time.length;
        _time = _time[len - 4] + _time[len - 2] + ':' + _time[len - 1] + number;
      }
    });
  }
  void _startPressed() {
    if (_time == '00:00') return;
    setState(() {
      if (_start == 'START') {
        _start = 'STOP';
      } else {
        _start = 'START';
      } 
    });
    Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) => setState(
        () {
          if (_start == 'START') {
            timer.cancel();
          } else {
            List t = _time.split(':');
            int sec = int.parse(t[0]) * 60 + int.parse(t[1]);
            sec--;
            _time = (sec ~/ 60).toString().padLeft(2, '0') +
              ':' +
              (sec % 60).toString().padLeft(2, '0');
            if (sec == 0) {
              timer.cancel();
              _start = 'START';
            }
          }
        }
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; //ウインドウサイズ取得
    final padding = MediaQuery.of(context).padding;
    var maxHeight =
        size.height - padding.top - kToolbarHeight; //ウインドウサイズからツールバーを除いた高さを計算

    //Widgetのサイズ作成
    final timeAreaHeight = maxHeight * (30 / 100);
    final buttomAreaHeight = maxHeight * (70 / 100);
    final buttomHeight = buttomAreaHeight * (30 / 100);
    final buttomWidth = size.width * (18 / 100);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.white),
              width: size.width,
              height: timeAreaHeight,
              padding: EdgeInsets.only(right: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '$_time',
                    style: TextStyle(fontSize: 40),
                  ),
                ],
              ),
            ),
            Container(
                decoration: BoxDecoration(color: Colors.white),
                width: size.width,
                height: buttomAreaHeight,
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            CustomButton(
                                text: "1",
                                width: buttomWidth,
                                height: buttomHeight,
                                onPressed: () => _numberPressed("1")),
                            CustomButton(
                                text: "2",
                                width: buttomWidth,
                                height: buttomHeight,
                                onPressed: () => _numberPressed("2")),
                            CustomButton(
                                text: "3",
                                width: buttomWidth,
                                height: buttomHeight,
                                onPressed: () => _numberPressed("3")),
                            CustomButton(
                                text: "4",
                                width: buttomWidth,
                                height: buttomHeight,
                                onPressed: () => _numberPressed("4")),
                            CustomButton(
                                text: "5",
                                width: buttomWidth,
                                height: buttomHeight,
                                onPressed: () => _numberPressed("5")),
                          ]),
                      Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            CustomButton(
                                text: "6",
                                width: buttomWidth,
                                height: buttomHeight,
                                onPressed: () => _numberPressed("6")),
                            CustomButton(
                                text: "7",
                                width: buttomWidth,
                                height: buttomHeight,
                                onPressed: () => _numberPressed("7")),
                            CustomButton(
                                text: "8",
                                width: buttomWidth,
                                height: buttomHeight,
                                onPressed: () => _numberPressed("8")),
                            CustomButton(
                                text: "9",
                                width: buttomWidth,
                                height: buttomHeight,
                                onPressed: () => _numberPressed("9")),
                            CustomButton(
                                text: "0",
                                width: buttomWidth,
                                height: buttomHeight,
                                onPressed: () => _numberPressed("0"))
                          ]),
                      Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            CustomButton(
                                text: "$_start",
                                width: size.width * (90 / 100),
                                height: buttomHeight,
                                onPressed: _startPressed)
                          ])
                    ]))
          ],
        )),
    );
  }
}
