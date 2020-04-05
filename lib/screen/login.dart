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
  String _password;
  String _vehicleNumber;

  final TextEditingController _vehicleNumberController =
      TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  static const ShapeDecoration _decoration = ShapeDecoration(
    shape: BeveledRectangleBorder(
      side: BorderSide(color: Colors.grey, width: 0.5),
      borderRadius: BorderRadius.all(Radius.circular(7.0)),
    ),
  );

  save({String id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('logined', true);
    prefs.setString('vehicleId', id);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Select()));
  }

  login({String username, String password}) async {
    this._vehicleNumber = username;
    this._password = password;
    print('username: $username password : $password');
    try {
      Response response = await Dio().post(
        api + 'vehicle/login.php',
        data: {
          "regno": _vehicleNumber,
          "password": _password,
        },
      );
      if (response.statusCode == 200) {
        String vehicleId = response.data['records'][0]['id'].toString();
        save(id: vehicleId);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                      controller: this._vehicleNumberController,
                      textInputAction: TextInputAction.done,
                      textCapitalization: TextCapitalization.characters,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.local_shipping),
                        labelText: '  Vehicle Number',
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.0)),
                          ),
                          onPressed: () {
                            login(
                              username: this._vehicleNumberController.text,
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
