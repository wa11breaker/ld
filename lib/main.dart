import 'package:LondonDollar/screen/home.dart';
import 'package:LondonDollar/screen/login.dart';
import 'package:LondonDollar/screen/select.dart';
import 'package:LondonDollar/screen/test.dart';
import 'package:LondonDollar/services/pref.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
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
            // /avto: Login(),
            // HomeScreen(),
            // Test(),
            Select(),
        '/select': (context) =>
            // navto: Select(),
            Test(),
        '/menue': (context) =>
            // navto: HomeScreen(),
            Test(),
      },
    ),
  );
}

// class Animation extends StatelessWidget {
//   final Widget navto;

//   const Animation({Key key, this.navto}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'London Dollar',
//       theme: ThemeData(
//         primarySwatch: Colors.amber,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: navto,
//     );
//   }
// }
