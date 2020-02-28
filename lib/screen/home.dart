import 'package:LondonDollar/screen/select.dart';
import 'package:LondonDollar/services/pref.dart';
import 'package:LondonDollar/widget/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';

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

  geta() async {
    List temp = await Sp().checkAllCardState();
    setState(() {
      a = temp[0];
      b = temp[1];
      c = temp[2];
      d = temp[3];
      aa = temp[4];
      bb = temp[5];
      cc = temp[6];
      dd = temp[7];
      next = temp[8];
      index = temp[9];
    });
  }

  @override
  initState() {
    super.initState();
    geta();
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
                  Sp().savCard('aa');
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
                    Sp().savCard('bb');
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
                    Sp().savCard('cc');
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
                    Sp().savCard('dd');
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
              if (dd) {
                setState(() {
                  Sp().workDone();
                  
                  Sp().resetAllCardState();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Select()));
                });
              }
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
                  Sp().savCard('a');
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
                    Sp().savCard('b');
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
                    Sp().savCard('c');
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
                    Sp().savCard('d');
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
                if (d) {
                  index = 1;
                  Sp().savCard('next');
                  Sp().savIndex('index',1);
                }
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
