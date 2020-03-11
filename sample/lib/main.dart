import 'package:flutter/material.dart';
import 'package:networking/networking.dart';
import 'package:sample/api/podo/my_learning.dart';

import 'api/podo/register_request.dart';
import 'api/podo/register_response.dart';

void main() {
  NetworkingFactory.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;

      RegisterRequest request = new RegisterRequest(
        "eve.holt@reqres.in",
        "pistol",
      );

      MyLearning learning = new MyLearning();
      NetworkingFactory.init();
      var manager = NetworkingFactory.create(learning: learning);
      manager
          .post<RegisterRequest, RegisterResponse>(
              url: "https://reqres.in/api/register",
              body: request,
              type: new RegisterResponse(),
              listener: new NetworkListener()
                ..onSuccess((result) {
                  print("success");
                })
                ..onError((error) {
                  print("fail");
                }))
          .cache(
            enabled: true,
            key: "hello",
            duration: Duration(days: 5),
            recoverFromException: true,
            encrypted: true,
          )
          .fetch()
            ..then((asd) {
              print("aa");
            }).catchError((error) {
              print("bb");
            });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hello"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class NetworkManager {}
