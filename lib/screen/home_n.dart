import 'package:LondonDollar/congif/color.dart';
import 'package:LondonDollar/congif/constants.dart';
import 'package:LondonDollar/screen/select.dart';
import 'package:LondonDollar/services/pref.dart';
import 'package:LondonDollar/widget/card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class HomeScreenN extends StatefulWidget {
  @override
  _HomeScreenNState createState() => _HomeScreenNState();
}

class _HomeScreenNState extends State<HomeScreenN> {
  bool siteGateIn = false;
  bool siteGateOut = false;
  bool portGateIn = false;
  bool portGateOut = false;
  bool compleated = false;

  String weightIn;
  String siteWeightOut;
  String challan;
  String tripId;

  ///
  String beforeunloadweight;
  String unloadweight;

  final TextEditingController _siteWeightOutController =
      TextEditingController();
  final TextEditingController _challanNoController = TextEditingController();

  final TextEditingController _weightbeforeUnloadController =
      TextEditingController();
  final TextEditingController _weightafterUnloadController =
      TextEditingController();

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

  getTipId() async {
    tripId = await Sp().getDriverId();
  }

  siteIn() async {
    if (!siteGateIn) {
      try {
        var now = DateTime.now();
        String formattedDate = DateFormat('yyy-MM-dd H:m:s').format(now);
        Response response = await Dio().post(
          api + "trip/entersite.php",
          data: {"id": tripId, "siteenter": formattedDate},
        );
        if (response.statusCode == 200) {
          Sp().savCard('siteGateIn');
          setState(
            () {
              siteGateIn = true;
            },
          );
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  siteOut() async {
    if (siteGateIn && !siteGateOut) {
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
                      controller: _siteWeightOutController,
                      decoration: const InputDecoration(
                        labelText: '  Weight out',
                      ),
                      onSubmitted: (value) {
                        siteWeightOut = value;
                      },
                    ),
                  ),
                  Container(
                    child: TextField(
                      controller: _challanNoController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: '  Challan Number',
                      ),
                      onSubmitted: (value) {
                        challan = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Save"),
                onPressed: () async {
                  setState(
                    () {
                      siteWeightOut = _siteWeightOutController.text;
                      challan = _challanNoController.text;
                    },
                  );
                  try {
                    var now = DateTime.now();
                    String formattedDate =
                        DateFormat('yyy-MM-dd H:m:s').format(now);
                    Response response = await Dio().post(
                      api + "trip/exitsite.php",
                      data: {
                        "id": tripId,
                        "siteexit": formattedDate,
                        // "challanno": challan,
                        "siteloadedwt": siteWeightOut
                      },
                    );
                    if (response.statusCode == 200) {
                      setState(() {
                        siteGateOut = true;
                      });
                      Sp().savCard('siteGateOut');
                      Navigator.of(context).pop();
                    }
                  } catch (e) {
                    print(e.toString());
                  }
                },
              ),
            ],
          );
        },
      );
    }
  }

  portIn() async {
    if (siteGateOut && !portGateIn) {
      try {
        var now = DateTime.now();
        String formattedDate = DateFormat('yyy-MM-dd H:m:s').format(now);
        Response response = await Dio().post(
          api + "trip/enterport.php",
          data: {"id": tripId, "portenter": formattedDate},
        );
        if (response.statusCode == 200) {
          setState(
            () {
              portGateIn = true;
            },
          );
          Sp().savCard('portGateOut');
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  portOut() {
    if (portGateIn && !portGateOut) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Weight In"),
            content: Column(
              children: <Widget>[
                Container(
                  child: TextField(
                    controller: _weightbeforeUnloadController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: '  weight in',
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        beforeunloadweight = value;
                      });
                    },
                  ),
                ),
                Container(
                  child: TextField(
                    controller: _weightafterUnloadController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: '  weight after unload',
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        unloadweight = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Save"),
                onPressed: () async {
                  setState(
                    () {
                      beforeunloadweight = _weightbeforeUnloadController.text;
                      unloadweight = _weightafterUnloadController.text;
                    },
                  );
                  try {
                    var now = DateTime.now();
                    String formattedDate =
                        DateFormat('yyy-MM-dd H:m:s').format(now);
                    Response response = await Dio().post(
                      api + "trip/unload.php",
                      data: {
                        "id": tripId,
                        "portunload": formattedDate,
                        "portloadedwt": beforeunloadweight,
                        "portunloadedwt": unloadweight
                      },
                    );
                    if (response.statusCode == 200) {
                      setState(() {
                        portGateOut = true;
                      });
                    }
                  } catch (e) {
                    print(e.toString());
                  }
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  initState() {
    super.initState();
    getTipId();
    geta();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
      ),
    );
  }

  Widget gridView() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          tripText(),
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
                    onTap: () => siteIn(),
                    child: Cards(
                      check: siteGateIn,
                      text: 'Site Gate In',
                      color: AppColors.red,
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => siteOut(),
                    child: Cards(
                      check: siteGateOut,
                      text: 'Site Gate Out',
                      secText: siteWeightOut,
                      color: AppColors.brown,
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => portIn(),
                    child: Cards(
                      check: portGateIn,
                      text: 'Port Gate In',
                      secText: weightIn,
                      color: AppColors.black,
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => portOut(),
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
          doneButton()
        ],
      ),
    );
  }

  Flexible tripText() {
    return Flexible(
      flex: 1,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Trip ID : $tripId',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
    );
  }

  Flexible doneButton() {
    return Flexible(
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
    );
  }
}
