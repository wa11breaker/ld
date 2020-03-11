import 'package:LondonDollar/congif/color.dart';
import 'package:LondonDollar/screen/select.dart';
import 'package:LondonDollar/services/pref.dart';
import 'package:LondonDollar/widget/card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  String weightIn;
  String weightOut;
  String chellan;
  final TextEditingController _weightInController = TextEditingController();
  final TextEditingController _weightOutController = TextEditingController();
  final TextEditingController _chellanNoController = TextEditingController();

  done() {
    if (portGateOut) {
      Sp().workDone();
      Sp().resetAllCardState();
      _success();
      // Navigator.push(
      // context, MaterialPageRoute(builder: (context) => Select()));
    }
  }

  void _success() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Work Compleated"),
          content: Container(
            child: Icon(
              Icons.check,
              size: 100,
              color: Colors.green,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Select()));
              },
            ),
          ],
        );
      },
    );
  }

  geta() async {
    List temp = await Sp().checkAllCardState(); // get saved bool form pref.dart
    setState(
      () {
        siteGateIn = temp[0];
        siteGateOut = temp[1];
        portGateIn = temp[2];
        portGateOut = temp[3];
      },
    );
  }

  siteGateInRequest() async {
    try {
      Response response = await Dio().post(
        "http://192.168.1.41:80/londollars/api/driver/create.php",
        data: {},
      );
      if (response.statusCode == 200) {}
    } catch (e) {
      print(e.toString());
    }
  }

  siteGateOutRequest() async {
    try {
      Response response = await Dio().post(
        "http://192.168.1.41:80/londollars/api/driver/create.php",
        data: {},
      );
      if (response.statusCode == 200) {}
    } catch (e) {
      print(e.toString());
    }
  }

  portGateInRequest() async {
    try {
      Response response = await Dio().post(
        "http://192.168.1.41:80/londollars/api/driver/create.php",
        data: {},
      );
      if (response.statusCode == 200) {}
    } catch (e) {
      print(e.toString());
    }
  }

  portGateInOut() async {
    try {
      Response response = await Dio().post(
        "http://192.168.1.41:80/londollars/api/driver/create.php",
        data: {},
      );
      if (response.statusCode == 200) {}
    } catch (e) {
      print(e.toString());
    }
  }

  void _weightout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Weight out"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: TextField(
                    controller: _weightOutController,
                    decoration: const InputDecoration(
                      labelText: '  weight out',
                    ),
                    onSubmitted: (value) {
                      weightOut = value;
                    },
                  ),
                ),
                Container(
                  child: TextField(
                    controller: _chellanNoController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: '  chellan Number',
                    ),
                    onSubmitted: (value) {
                      chellan = value;
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Save"),
              onPressed: () {
                setState(() {
                  weightOut = _weightOutController.text;
                  chellan = _chellanNoController.text;
                  siteGateOut = true;
                });
                Sp().savCard('siteGateOut');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _weightin() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Weight In"),
          content: Container(
            child: TextField(
              controller: _weightInController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '  weight in',
              ),
              onSubmitted: (value) {
                setState(() {
                  weightIn = value;
                  print(weightIn);
                });
              },
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Save"),
              onPressed: () {
                setState(() {
                  weightIn = _weightInController.text;
                  portGateIn = true;
                });
                Sp().savCard('portGateIn');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _chellanNumber() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Weight out"),
          content: Container(
            child: TextField(
              controller: _chellanNoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '  chellan Number',
              ),
              onSubmitted: (value) {
                chellan = value;
              },
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Save"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
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
                'Trip ID : xx',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
                      if (siteGateIn) {
                        _weightout();
                      }
                    },
                    child: Cards(
                      check: siteGateOut,
                      text: 'Site Gate Out',
                      secText: weightOut,
                      color: AppColors.brown,
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      if (siteGateOut) {
                        _weightin();
                      }
                    },
                    child: Cards(
                      check: portGateIn,
                      text: 'Port Gate In',
                      secText: weightIn,
                      color: AppColors.black,
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      setState(
                        () {
                          if (portGateIn) {
                            portGateOut = true;

                            Sp().savCard('portGateOut');
                          }
                        },
                      );
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
                  borderRadius: BorderRadius.circular(10),
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
