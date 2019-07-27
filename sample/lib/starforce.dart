import 'package:flutter/material.dart';
import 'package:sample/api/manager.dart';

class StarforceView extends StatefulWidget {
  @override
  _StarforceViewState createState() => _StarforceViewState();
}

class _StarforceViewState extends State<StarforceView> {
  ApiManager _apiManager = ApiManager.getInstance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[_deleteRequest],
        ),
      ),
    );
  }

  Widget get _appbar => AppBar(
        title: Text("StartForce Networking Sample"),
      );

  Widget get _deleteRequest => RaisedButton.icon(
        icon: Icon(Icons.delete),
        onPressed: () async {
          await _apiManager .deleteFirebaseChild(child: "sample");
        },
        label: Text("Try Networking DELETE Request"),
      );
}
