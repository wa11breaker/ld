import 'package:LondonDollar/widget/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool a = false;
  bool b = false;
  bool c = false;
  bool d = false;
  bool next = false;
  final Location location = new Location();

  LocationData _location;
  String _error;

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
          child: Column(
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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  color: next ? Colors.green : Colors.transparent,
                  onPressed: () {},
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
          ),
        ),
      ),
    );
  }
}
