import 'package:LondonDollar/screen/home.dart';
import 'package:LondonDollar/screen/login.dart';
import 'package:LondonDollar/screen/select.dart';
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
      initialRoute: rout,
      routes: {
        '/': (context) => Login(),
        '/select': (context) => Select(),
        '/menue': (context) => HomeScreen(),
      },
    ),
  );
}

/* class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'London Dollar',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen.navigate(
          name: 'assets/splash.flr',
          next: (context) => Login(),
          startAnimation: 'Untitled',
          backgroundColor: Color(0xffffffff),
          until: () => Future.delayed(Duration(seconds: 3)),
        ));
  }
} */

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Location',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: HomeScreen(),
    );
  }
}
