import 'package:LondonDollar/congif/color.dart';
import 'package:LondonDollar/screen/select.dart';
import 'package:LondonDollar/services/pref.dart';
import 'package:LondonDollar/widget/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool siteGateIn = false;
  bool siteGateOut = false;
  bool portGateIn = false;
  bool portGateOut = false;
  bool compleated = false;

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

  done() {
    if (portGateOut) {
      Sp().workDone();
      Sp().resetAllCardState();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Select()));
    }
  }

  geta() async {
    List temp = await Sp().checkAllCardState();// get saved bool form pref.dart
    setState(
      () {
        siteGateIn = temp[0];
        siteGateOut = temp[1];
        portGateIn = temp[2];
        portGateOut = temp[3];
      },
    );
  }

  @override
  initState() {
    super.initState();
    geta();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 28,
            right: 28,
          ),
          child: gridView(),
        ),
      ),
    );
  }

  Widget gridView() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'London Dollar',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: GridView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 30,
                ),
                children: <Widget>[
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      _getLocation();
                      setState(() {
                        siteGateIn = true;
                        Sp().savCard('siteGateIn');
                      });
                    },
                    child: Cards(
                      check: siteGateIn,
                      text: 'Site Gate In',
                      color: AppColors.red,
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      _getLocation();
                      setState(() {
                        if (siteGateIn) {
                          siteGateOut = true;
                          Sp().savCard('siteGateOut');
                        }
                      });
                    },
                    child: Cards(
                      check: siteGateOut,
                      text: 'Site Gate Out',
                      color: AppColors.brown,
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      _getLocation();
                      setState(() {
                        if (siteGateOut) {
                          portGateIn = true;
                          Sp().savCard('portGateIn');
                        }
                      });
                    },
                    child: Cards(
                      check: portGateIn,
                      text: 'Port Gate In',
                      color: AppColors.black,
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      _getLocation();
                      setState(() {
                        if (portGateIn) {
                          portGateOut = true;

                          Sp().savCard('portGateOut');
                        }
                      });
                    },
                    child: Cards(
                      check: portGateOut,
                      text: 'Port Gate Out',
                      color: AppColors.teal,
                    ),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: PhysicalShape(
              color: AppColors.blue,
              clipper: ShapeBorderClipper(
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Container(
                width: double.infinity,
                height: 50,
                child: FlatButton(
                  onPressed: () {
                    done();
                  },
                  child: Text(
                    'DONE',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      letterSpacing: 1.3,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}