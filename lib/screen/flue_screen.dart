import 'dart:convert';
import 'package:LondonDollar/services/pref.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:http/http.dart' as http;
import 'package:LondonDollar/congif/color.dart';
import 'package:LondonDollar/congif/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Fuel extends StatefulWidget {
  @override
  _FlueState createState() => _FlueState();
}

class _FlueState extends State<Fuel> {
  static const ShapeDecoration _decoration = ShapeDecoration(
    shape: BeveledRectangleBorder(
      side: BorderSide(color: Colors.grey, width: 0.5),
      borderRadius: BorderRadius.all(Radius.circular(7.0)),
    ),
  );
  String vehicleId;
  final TextEditingController qty = new TextEditingController();
  final TextEditingController rate = new TextEditingController();
  List<String> fule = ['Petrol', 'Diesel'];
  List<String> fuelSupply = List();

  String selectedFuile;
  String selectedFuelSupplyer;
  String fuelImageName;

  getVehiclerId() async {
    vehicleId = await Sp().getVehiclerId();
  }

  createFul({String qty, String supplier, String rate}) async {
    try {
      var now = DateTime.now();
      String formattedDate = DateFormat('yyy-MM-dd H:m:s').format(now);
      Response response = await Dio().post(
        api + "fuel/create.php",
        data: {
          "fdate": formattedDate,
          "fueltype": selectedFuile,
          "fuelsupplier": fuelSupply.indexOf(selectedFuelSupplyer),
          "qty": qty,
          "rate": rate,
          "image": fuelImageName,
          "vehicleid": vehicleId,
        },
      );
      if (response.statusCode == 201) {
        _success();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void _success() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Fuel Added"),
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
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera,
        maxHeight: 500,
        maxWidth: 500,
        imageQuality: 100);
    if (image != null) {
      String base64Image = base64Encode(image.readAsBytesSync());
      String fileName = image.path.split("/").last;
      setState(() {
        fuelImageName = fileName;
      });

      http.post("$api/fuelimage.php", body: {
        "image": base64Image,
        "name": fileName,
      }).then((res) {
        print(res.body.toString());
      }).catchError((err) {
        print(err);
      });
    }
  }

  Future<void> getFuelSupplier() async {
    var res = await http.get('$api' + "fuelsupplier/read.php");
    var jsonres = json.decode(res.body);
    if (res.statusCode == 200) {
      for (int i = 0; i < jsonres['records'].length; i++) {
        fuelSupply.add(jsonres['records'][i]['suppliername']);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getVehiclerId();
    getFuelSupplier();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: null,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.fromLTRB(28, 0, 28, 0),
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                2 * AppBar().preferredSize.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: _decoration,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.local_gas_station,
                          color: Colors.black54,
                        ),
                      ),
                      DropdownButton(
                        // isExpanded: true,
                        underline: Container(),
                        hint: Text('  Select Fuel Type'),
                        value: selectedFuile,
                        onChanged: (value) {
                          setState(() {
                            selectedFuile = value;
                          });
                        },
                        items: fule.map((fuel) {
                          return DropdownMenuItem(
                            child: Text(fuel),
                            value: fuel,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: _decoration,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.local_gas_station,
                          color: Colors.black54,
                        ),
                      ),
                      DropdownButton(
                        // isExpanded: true,
                        underline: Container(),
                        hint: Text('  Select Fuel Supplier'),
                        value: selectedFuelSupplyer,
                        onChanged: (newValue) {
                          setState(() {
                            selectedFuelSupplyer = newValue;
                          });
                        },
                        items: fuelSupply.map((materail) {
                          return DropdownMenuItem(
                            child: Text(materail),
                            value: materail,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: _decoration,
                  child: TextField(
                    controller: this.qty,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.local_gas_station),
                      labelText: '  Volume',
                    ),
                  ),
                ),

                Container(
                  decoration: _decoration,
                  child: TextField(
                    controller: this.rate,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 12),
                        child: Text(
                          "\u20B9",
                          style: TextStyle(fontSize: 30, color: Colors.grey),
                        ),
                      ),
                      labelText: '  Rate',
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: getImage,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 12),
                    decoration: _decoration,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.camera_alt),
                        SizedBox(width: 20),
                        Text('Upload Image')
                      ],
                    ),
                  ),
                ),

                PhysicalShape(
                  color: AppColors.black,
                  clipper: ShapeBorderClipper(
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    child: FlatButton(
                      onPressed: () {
                        createFul(
                          qty: qty.text,
                          rate: rate.text,
                          supplier: selectedFuelSupplyer,
                        );
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
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
