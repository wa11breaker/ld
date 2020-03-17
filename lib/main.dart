import 'package:LondonDollar/screen/home_n.dart';
import 'package:LondonDollar/screen/login.dart';
import 'package:LondonDollar/screen/select.dart';
import 'package:LondonDollar/services/pref.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String rout = '/';
  bool logined = await Sp().checkLogin();
  bool onwork = await Sp().checkOnWork();
  ////////////
  if (logined == false) {
    rout = '/';
  } else if (logined && onwork == false) {
    rout = '/select';
  } else if (logined && onwork) {
    rout = '/menue';
  }

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: rout,
      routes: {
        '/': (context) =>
            
            Login(),
        '/select': (context) =>
            
            Select(),
           
        '/menue': (context) =>
            
            HomeScreenN(),
         
      },
    ),
  );
}
