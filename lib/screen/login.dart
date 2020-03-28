import 'package:LondonDollar/congif/color.dart';
import 'package:LondonDollar/congif/constants.dart';
import 'package:LondonDollar/screen/select.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _driverId;
  String _driverName;

  var _password;
  var _username;

  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passController = new TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  static const ShapeDecoration _decoration = ShapeDecoration(
    shape: BeveledRectangleBorder(
      side: BorderSide(color: Colors.grey, width: 0.5),
      borderRadius: BorderRadius.all(Radius.circular(7.0)),
    ),
  );
  save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('logined', true);
    prefs.setString('driverid', _driverId);
    prefs.setString('drivername', _driverName);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Select()));
  }

  login({String username, String password}) async {
    this._username = username;
    this._password = password;
    print('username: $username password : $password');
    try {
      Response response = await Dio().post(
        api + 'driver/login.php',
        data: {
          "username": _username,
          "password": _password,
        },
      );
      if (response.statusCode == 200) {
        var driverName = response.data['records'][0]['name'];
        var driverId = response.data['records'][0]['id'];
        setState(
          () {
            _driverId = driverId;
            _driverName = driverName;
            save();
          },
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset(
                  'assets/logo.jpg',
                  height: 100,
                ),
                const SizedBox(height: 16.0),
                Text(
                  'LONDON DOLLAR',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            const SizedBox(height: 60.0),
            PrimaryColorOverride(
              color: Colors.black,
              child: Container(
                decoration: _decoration,
                child: TextField(
                  controller: this._emailController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.person),
                    labelText: '  User name',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            PrimaryColorOverride(
              color: Colors.black,
              child: Container(
                decoration: _decoration,
                child: TextField(
                  controller: this._passController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.lock),
                    labelText: '  Password',
                  ),
                ),
              ),
            ),
            Wrap(
              children: <Widget>[
                ButtonBar(
                  children: <Widget>[
                    RaisedButton(
                      color: AppColors.black,
                      child: const Text('NEXT'),
                      elevation: 8.0,
                      shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      ),
                      onPressed: () {
                        login(
                          username: this._emailController.text,
                          password: this._passController.text,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PrimaryColorOverride extends StatelessWidget {
  const PrimaryColorOverride({Key key, this.color, this.child})
      : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(primaryColor: color),
    );
  }
}
