import 'package:LondonDollar/widget/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool a = false;
  bool b = false;
  bool c = false;
  bool d = false;
  bool aa = false;
  bool bb = false;
  bool cc = false;
  bool dd = false;
  bool next = false;
  bool compleated = false;
  int index = 0;

  final Location location = new Location();

  LocationData _location;
  String _error;

  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int counter = (prefs.getInt('counter') ?? 0) + 1;

    await prefs.setInt('counter', counter);
  }

  _getLocation() async {
    setState(() {
      _error = null;
    });
    try {
      var _locationResult = await location.getLocation();
      setState(() {
        _location = _locationResult;
        print(_location ?? _error);
      });
    } on PlatformException catch (err) {
      setState(() {
        _error = err.code;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: IndexedStack(
            index: index,
            children: <Widget>[
              firstHalf(),
              secondHalf(),
            ],
          ),
        ),
      ),
    );
  }

  Column secondHalf() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 5,
                      width: 30,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    Image.asset(
                      'assets/truck.png',
                      color: Colors.black,
                      scale: 1.5,
                    )
                  ],
                ),
              ),
            ),
            Icon(
              Icons.outlined_flag,
              size: 30,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                _getLocation();
                setState(() {
                  aa = true;
                });
              },
              child: Cards(
                check: aa,
                text: 'At site',
              ),
            ),
            GestureDetector(
              onTap: () {
                _getLocation();
                setState(() {
                  if (aa) {
                    bb = true;
                  }
                });
              },
              child: Cards(
                check: bb,
                text: 'At Gate',
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                _getLocation();
                setState(() {
                  if (bb) {
                    cc = true;
                  }
                });
              },
              child: Cards(
                check: cc,
                text: 'At Gate',
              ),
            ),
            GestureDetector(
              onTap: () {
                _getLocation();
                setState(() {
                  if (cc) {
                    dd = true;
                    compleated = true;
                  }
                });
              },
              child: Cards(
                check: dd,
                text: 'At Gate',
              ),
            )
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: FlatButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            color: compleated ? Colors.green : Colors.white,
            onPressed: () {
              setState(() {});
            },
            child: Text(
              'Done',
              style: TextStyle(
                color: compleated ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 1.3,
              ),
            ),
          ),
        )
      ],
    );
  }

  Column firstHalf() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 5,
                      width: 30,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    Image.asset(
                      'assets/truck.png',
                      color: Colors.black,
                      scale: 1.5,
                    )
                  ],
                ),
              ),
            ),
            Icon(
              Icons.outlined_flag,
              size: 30,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                _getLocation();
                setState(() {
                  a = true;
                });
              },
              child: Cards(
                check: a,
                text: 'At Gate',
              ),
            ),
            GestureDetector(
              onTap: () {
                _getLocation();
                setState(() {
                  if (a) {
                    b = true;
                  }
                });
              },
              child: Cards(
                check: b,
                text: 'At Gate',
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                _getLocation();
                setState(() {
                  if (b) {
                    c = true;
                  }
                });
              },
              child: Cards(
                check: c,
                text: 'At Gate',
              ),
            ),
            GestureDetector(
              onTap: () {
                _getLocation();
                setState(() {
                  if (c) {
                    d = true;
                    next = true;
                  }
                });
              },
              child: Cards(
                check: d,
                text: 'At Gate',
              ),
            )
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: FlatButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            color: next ? Colors.green : Colors.transparent,
            onPressed: () {
              setState(() {
                index = 1;
              });
            },
            child: Text(
              'NEXT',
              style: TextStyle(
                color: next ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 1.3,
              ),
            ),
          ),
        )
      ],
    );
  }
}
