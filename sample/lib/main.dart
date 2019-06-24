import 'package:flutter/material.dart';
import 'package:networking/networking.dart';
import 'package:sample/api/podo/my_learning.dart';
import 'package:sample/api/podo/post_response.dart';
import 'package:sample/api/podo/register_request.dart';
import 'package:sample/api/podo/register_response.dart';
import 'package:sample/api/reqresin_error.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
      NetworkManager manager = NetworkingFactory.create(learning: learning);
      manager
          .post<RegisterRequest, RegisterResponse, ReqResInError>(
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
          .fetch()
            ..then((asd) {
              print("aa");
            }).catchError((error) {
              print("bb");
            });

//      manager
//          .get<PostResponse, ReqResInError>(
//              url: "https://jsonplaceholder.typicode.com/posts",
//              type: new PostResponse(),
//              asList: true,
//              listener: new NetworkListener()
//                ..onSuccess((result) {
//                  print("hello");
//                })
//                ..onError((error) {
//                  print("world");
//                }))
//          .enqueue();
    });
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
