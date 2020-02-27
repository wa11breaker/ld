import 'package:LondonDollar/screen/home.dart';
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
      next: (context) => HomeScreen(),
      startAnimation: 'Untitled',
      backgroundColor: Color(0xffffffff),
      until: () => Future.delayed(Duration(seconds: 3)),
    )
    );
    
  }
}
