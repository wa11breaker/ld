import 'package:LondonDollar/screen/select.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
                onChanged: (text) {
                  // number = text;
                },
              ),
              SizedBox(height: 25),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                onChanged: (text) {
                  // number = text;
                },
              ),
              SizedBox(height: 60),
              FlatButton(
                color: Colors.green,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Select(),
                    ),
                  );
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
