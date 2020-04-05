import 'package:LondonDollar/congif/color.dart';
import 'package:LondonDollar/congif/constants.dart';
import 'package:LondonDollar/screen/flue_screen.dart';
import 'package:LondonDollar/screen/select.dart';
import 'package:LondonDollar/services/pref.dart';
import 'package:LondonDollar/widget/card.dart';
import 'package:dio/dio.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  String siteWeightOut;
  String challan;
  String tripId;

  String beforeunloadweight;
  String unloadweight;

  TextEditingController _siteWeightOutController = TextEditingController();
  TextEditingController _challanNoController = TextEditingController();

  TextEditingController _weightbeforeUnloadController = TextEditingController();
  TextEditingController _weightafterUnloadController = TextEditingController();
  TextEditingController _ticketNumberController = TextEditingController();

  String sInTime;
  String sOutTime;
  String pInTime;
  String pOutTime;

  String sInDate;
  String sOutDate;
  String pInDate;
  String pOutDate;

  String beforeunloadweDate;
  String unloadweDate;
  String ticketNo;

  getAllWeight() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sInTime = prefs.getString('sInTime') ?? '';
    sOutTime = prefs.getString('sOutTime') ?? '';
    pInTime = prefs.getString('pInTime') ?? '';
    pOutTime = prefs.getString('pOutTime') ?? '';

    sInDate = prefs.getString('sInDate') ?? '';
    sOutDate = prefs.getString('sOutDate') ?? '';
    pInDate = prefs.getString('pInDate') ?? '';
    pOutDate = prefs.getString('pOutDate') ?? '';

    challan = prefs.getString('challan') ?? '';
    siteWeightOut = prefs.getString('siteWeightOut') ?? '';
    beforeunloadweight = prefs.getString('beforeunloadweight') ?? '';
    unloadweight = prefs.getString('unloadweight') ?? '';
    ticketNo = prefs.getString('ticketno') ?? '';
  }

  updateTD(tname, time, dname, date) {
    Sp().saveString(tname, time);
    Sp().saveString(dname, date);
  }

  //update weight
  updateW(wname, weight) {
    Sp().saveString(wname, weight);
  }

  void dispose() {
    _siteWeightOutController.dispose();
    _challanNoController.dispose();
    _weightbeforeUnloadController.dispose();
    _weightafterUnloadController.dispose();

    super.dispose();
  }

  done() {
    if (portGateOut) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Work Completed"),
            content: Container(
              height: 150,
              child: FlareActor(
                'assets/check_do_sucesso.flr',
                animation: "Untitled",
                fit: BoxFit.contain,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Close"),
                onPressed: () {
                  Sp().workDone();
                  Sp().resetAllCardState();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Select()));
                },
              ),
            ],
          );
        },
      );
    }
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
    tripId = await Sp().getTripId();
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
              sInTime = DateFormat('H:m:s').format(now);
              sInDate = DateFormat('yyy-MM-dd').format(now);
              updateTD(
                'sInTime',
                DateFormat('H:m:s').format(now),
                'sInDate',
                DateFormat('yyy-MM-dd').format(now),
              );
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
            title: Text("Site Out"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: TextField(
                      controller: _siteWeightOutController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: '  Loaded Weight (Ton)',
                      ),
                      onSubmitted: (value) {
                        siteWeightOut = value;
                      },
                    ),
                  ),
                  Container(
                    child: TextField(
                      controller: _challanNoController,
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
                        "challanno": challan,
                        "siteloadedwt": siteWeightOut
                      },
                    );
                    if (response.statusCode == 200) {
                      setState(() {
                        siteGateOut = true;
                        updateW('siteWeightOut', siteWeightOut);
                        updateW('challan', challan);

                        sOutTime = DateFormat('H:m:s').format(now);
                        sOutDate = DateFormat('yyy-MM-dd').format(now);
                        updateTD(
                          'sOutTime',
                          DateFormat('H:m:s').format(now),
                          'sOutDate',
                          DateFormat('yyy-MM-dd').format(now),
                        );
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
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Port In"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: TextField(
                    controller: _weightbeforeUnloadController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: '  Loaded Weight (Ton)',
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        beforeunloadweight = value;
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
                    },
                  );
                  try {
                    var now = DateTime.now();
                    String formattedDate =
                        DateFormat('yyy-MM-dd H:m:s').format(now);
                    Response response = await Dio().post(
                      api + "trip/enterport.php",
                      data: {
                        "id": tripId,
                        "portenter": formattedDate,
                        "portloadedwt": beforeunloadweight,
                      },
                    );
                    if (response.statusCode == 200) {
                      setState(
                        () {
                          portGateIn = true;
                          pInTime = DateFormat('H:m:s').format(now);
                          pInDate = DateFormat('yyy-MM-dd').format(now);
                        },
                      );
                      updateTD(
                        'pInTime',
                        DateFormat('H:m:s').format(now),
                        'pInDate',
                        DateFormat('yyy-MM-dd').format(now),
                      );
                      Sp().savCard('portGateIn');
                      updateW('beforeunloadweight', beforeunloadweight);
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

  portOut() {
    if (portGateIn && !portGateOut) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Port Out"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: TextField(
                    controller: _weightafterUnloadController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: '  Empty Weight (Ton)',
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        unloadweight = value;
                      });
                    },
                  ),
                ),
                Container(
                  child: TextField(
                    controller: _ticketNumberController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: '  Ticket Number',
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        ticketNo = value;
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
                      ticketNo = _ticketNumberController.text;
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
                        "ticketno": ticketNo,
                        "portunloadedwt": unloadweight
                      },
                    );
                    if (response.statusCode == 200) {
                      setState(() {
                        portGateOut = true;

                        pOutTime = DateFormat('H:m:s').format(now);
                        pOutDate = DateFormat('yyy-MM-dd').format(now);
                        updateTD(
                          'pOutTime',
                          DateFormat('H:m:s').format(now),
                          'pOutDate',
                          DateFormat('yyy-MM-dd').format(now),
                        );
                      });

                      updateW('unloadweight', unloadweight);
                      updateW('ticketno', ticketNo);

                      Sp().savCard('portGateOut');
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

  @override
  initState() {
    super.initState();
    getTipId();
    geta();
    getAllWeight();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
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
                      date: sInDate,
                      time: sInTime,
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => siteOut(),
                    child: Cards(
                      check: siteGateOut,
                      text: 'Site Gate Out',
                      sectext: challan,
                      weight1: siteWeightOut,
                      date: sOutDate,
                      time: sOutTime,
                      color: AppColors.brown,
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => portIn(),
                    child: Cards(
                      check: portGateIn,
                      text: 'Port Gate In',
                      color: AppColors.blue,
                      date: pInDate,
                      time: pInTime,
                      weight1: beforeunloadweight,
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => portOut(),
                    child: Cards(
                      check: portGateOut,
                      text: 'Port Gate Out',
                      color: AppColors.teal,
                      date: pOutDate,
                      time: pOutTime,
                      weight2: unloadweight,
                      ticket: ticketNo,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Trip ID : $tripId',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Fuel())),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.local_gas_station,
                    size: 35,
                  ),
                  Text(
                    'Fuel',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Flexible doneButton() {
    return Flexible(
      flex: 1,
      child: PhysicalShape(
        color: AppColors.black,
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
