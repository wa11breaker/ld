import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  String resposce;
  List<String> place = [];

  getR() async {
    try {
      List<String> tempPlace = [];
      Response response = await Dio()
          .get('http://192.168.18.3:80/londollars/api/project/read.php');

      var json = response.data['records'];
      int listLenght = json.length;
      for (int i = 0; i < listLenght; i++) {
        // print("${json[i]['sitename']}");
        tempPlace.add(json[i]['sitename']);
        print(tempPlace);
      }

      setState(
        () {
          // resposce = prettyJson;
          resposce = json.length.toString();
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

  post() async {
    FormData formData = FormData.fromMap({
      "name": "1234567 ",
      "licenseno": "123456",
      "username": "rams",
      "password": "123s"
    });
    Response response = await Dio().post(
        "http://192.168.1.41:80/londollars/api/driver/create.php",
        data: formData);
    getR();
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
                  child: Text("$resposce" ?? 'null'),
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
                // post();
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
