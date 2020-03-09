import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  String resposce;

  getR() async {
    try {
      Response response =
          await Dio().get('https://jsonplaceholder.typicode.com/todos');

      var json = response.data;
      JsonEncoder encoder = JsonEncoder.withIndent('  ');
      String prettyJson = encoder.convert(json);
      print(prettyJson);
      setState(
        () {
          resposce = prettyJson;
        },
      );
    } catch (e) {
      print(e.toString());
      setState(
        () {
          resposce = e.toString();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(),
            Scrollbar(
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.black12,
                height: 500,
                child: SingleChildScrollView(
                  child: Text(resposce ?? 'null'),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            FlatButton(
              color: Colors.black,
              onPressed: () {
                getR();
              },
              child: Text(
                'GET',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
