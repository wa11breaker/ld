import 'package:LondonDollar/congif/color.dart';
import 'package:LondonDollar/congif/constants.dart';
import 'package:LondonDollar/screen/home_n.dart';
import 'package:LondonDollar/services/pref.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Select extends StatefulWidget {
  @override
  _SelectState createState() => _SelectState();
}

class _SelectState extends State<Select> {
  List<String> _locations = [];
  List<String> _material = [];

  List<String> _locationsIndex = [];
  List<String> _materialIndex = [];
  //
  int _selectedLocationNo;
  int _selectedMaterialNo;
  //
  String _selectedLocation;
  String _selectedMAterial;
  String tripID;
  String vehicleId;

  getPlace() async {
    try {
      List<String> tempLoc = [];
      List<String> tempLocIndex = [];
      Response response = await Dio().get(api + 'project/read.php');

      var json = response.data['records'];
      int listLenght = json.length;
      for (int i = 0; i < listLenght; i++) {
        tempLoc.add(json[i]['sitename']);
        tempLocIndex.add(json[i]['id']);
      }
      setState(() {
        _locations = tempLoc;
        _locationsIndex = tempLocIndex;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  getMaterial() async {
    try {
      List<String> tempmet = [];
      List<String> tempmetIndex = [];
      Response response = await Dio().get(api + 'material/read.php');

      var json = response.data['records'];
      int listLenght = json.length;
      for (int i = 0; i < listLenght; i++) {
        tempmet.add(json[i]['material']);
        tempmetIndex.add(json[i]['id']);
      }
      setState(() {
        _material = tempmet;
        _materialIndex = tempmetIndex;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  ///save trip id
  save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('tripid', tripID);
  }

  createTask() async {
    try {
      Response response = await Dio().post(
        api + "/trip/createtrip.php",
        data: {
          "projectid": _locationsIndex[_selectedLocationNo],
          "materialid": _materialIndex[_selectedMaterialNo],
          "vehicleid": vehicleId,
        },
      );
      if (response.statusCode == 201) {
        var _tripId = response.data['id'].toString();
        setState(() {
          tripID = _tripId;
          save();
          onWork();
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  onWork() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('onwork', true);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreenN()));
  }

  getVehiclerId() async {
    vehicleId = await Sp().getVehiclerId();
  }

  @override
  void initState() {
    getVehiclerId();
    getMaterial();
    getPlace();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height -
                  2 * AppBar().preferredSize.height,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(28, 8, 28, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Start a new trip',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24)),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      // width: double.infinity,
                      child: DropdownButton(
                        isExpanded: true,
                        hint: Text('Select Material'),
                        value: _selectedMAterial,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedMAterial = newValue;
                            _selectedMaterialNo = _material.indexOf(newValue);
                          });
                        },
                        items: _material.map((materail) {
                          return DropdownMenuItem(
                            child: Text(materail),
                            value: materail,
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      // width: double.infinity,
                      child: DropdownButton(
                        isExpanded: true,
                        hint: Text('Select Site'),
                        value: _selectedLocation,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedLocation = newValue;
                            _selectedLocationNo = _locations.indexOf(newValue);
                          });
                        },
                        items: _locations.map((location) {
                          return DropdownMenuItem(
                            child: Text(location),
                            value: location,
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    RaisedButton(
                      color: AppColors.black,
                      child: Text(
                        'NEXT',
                        style: TextStyle(color: Colors.white.withOpacity(.95)),
                      ),
                      elevation: 8.0,
                      shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      ),
                      onPressed: createTask,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
