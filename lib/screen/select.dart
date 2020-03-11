import 'package:LondonDollar/congif/color.dart';
import 'package:LondonDollar/congif/constants.dart';
import 'package:LondonDollar/services/pref.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:LondonDollar/screen/home.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Select extends StatefulWidget {
  @override
  _SelectState createState() => _SelectState();
}

class _SelectState extends State<Select> {
  String driverid;
  List<String> _number = [];
  List<String> _locations = [];
  String _selectedLocation;
  String _selectedNumber;
  getNumber() async {
    try {
      List<String> tempNumber = [];
      //Todo: api endpoint number plate end point
      Response response = await Dio().get(api + '/project/read.php');

      var json = response.data['records'];
      int listLenght = json.length;
      for (int i = 0; i < listLenght; i++) {
        tempNumber.add(json[i]['sitename']);
      }
      setState(() {
        _number = tempNumber;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  getPlace() async {
    try {
      List<String> tempLoc = [];
      Response response = await Dio().get(api + '/project/read.php');

      var json = response.data['records'];
      int listLenght = json.length;
      for (int i = 0; i < listLenght; i++) {
        tempLoc.add(json[i]['sitename']);
      }
      setState(() {
        _locations = tempLoc;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  createTask() async {
    try {
      Response response = await Dio().post(
        "http://192.168.1.41:80/londollars/api/driver/create.php",
        data: {
          "licenseno": _selectedNumber,
          "password": _selectedLocation,
          "driverid": driverid,
        },
      );
      if (response.statusCode == 200) {
        onWork();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  onWork() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('onwork', true);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  getDriverId() async {
    driverid = await Sp().getDriverId();
  }

  @override
  void initState() {
    super.initState();
    getDriverId();
    getNumber();
    getPlace();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(),
              Container(
                // width: double.infinity,
                child: DropdownButton(
                  hint: Text('Choose a Number'),
                  value: _selectedNumber,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedNumber = newValue;
                    });
                  },
                  items: _number.map((number) {
                    return DropdownMenuItem(
                      child: Text(number),
                      value: number,
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 30),
              Container(
                // width: double.infinity,
                child: DropdownButton(
                  hint: Text('Choose a Location'),
                  value: _selectedLocation,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedLocation = newValue;
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
              SizedBox(height: 60),
              RaisedButton(
                color: AppColors.black,
                child: const Text(
                  'NEXT',
                  style: TextStyle(color: Colors.white70),
                ),
                elevation: 8.0,
                shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
                ),
                onPressed: () {
                  onWork();
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
