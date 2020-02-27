import 'package:LondonDollar/screen/home.dart';
import 'package:LondonDollar/screen/login.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      Main(),
    );

class Main extends StatelessWidget {
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
}
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
