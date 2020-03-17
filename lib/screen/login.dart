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

  String _email;
  String _password;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  static const ShapeDecoration _decoration = ShapeDecoration(
    shape: BeveledRectangleBorder(
      side: BorderSide(color: Color(0xFF442B2D), width: 0.5),
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

  login() async {
    print("Email: $_email, password: $_password");
    try {
      Response response = await Dio().post(
        api + 'driver/login.php',
        data: {
          "username": _email,
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
          },
        );
        save();
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
                // Image.asset('packages/shrine_images/diamond.png'),
                const SizedBox(height: 16.0),
                Text(
                  'LONDON DOLLAR',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            const SizedBox(height: 120.0),
            PrimaryColorOverride(
              color: Colors.brown,
              child: Container(
                decoration: _decoration,
                child: TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: '  User name',
                  ),
                  onSubmitted: (value) {
                    _email = value;
                  },
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            PrimaryColorOverride(
              color: Colors.brown,
              child: Container(
                decoration: _decoration,
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: '  Password',
                  ),
                  onSubmitted: (value) {
                    _password = value;
                  },
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
                        login();
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
