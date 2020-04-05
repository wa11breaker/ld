import 'package:LondonDollar/congif/color.dart';
import 'package:LondonDollar/congif/constants.dart';
import 'package:LondonDollar/screen/home_n.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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

  final TextEditingController fuelsupplier = new TextEditingController();
  final TextEditingController qty = new TextEditingController();
  final TextEditingController rate = new TextEditingController();
  List<String> fule = ['Petrol', 'Diesel'];
  String selectedFuile;

  createFul({String qty, String supplier, String rate}) async {
    try {
      var now = DateTime.now();
      String formattedDate = DateFormat('yyy-MM-dd H:m:s').format(now);
      Response response = await Dio().post(
        api + "fuel/create.php",
        data: {
          "fdate": formattedDate,
          "fueltype": selectedFuile,
          "fuelsupplier": supplier,
          "qty": qty,
          "rate": rate
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
          title: Text("Fule added"),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreenN()));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(28, 8, 28, 8),
          height: MediaQuery.of(context).size.height -
              2 * AppBar().preferredSize.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                      child: Icon(Icons.local_gas_station,color: Colors.black54,),
                    ),
                    DropdownButton(
                     // isExpanded: true,
                     underline: Container(
                     
                     ),
                      hint: Text('  Select Fuel Type'),
                      value: selectedFuile,
                      onChanged: (newValue) {
                        setState(() {
                          selectedFuile = newValue;
                        });
                      },
                      items: fule.map((materail) {
                        return DropdownMenuItem(
                          child: Text(materail),
                          value: materail,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40),
              Container(
                decoration: _decoration,
                child: TextField(
                  controller: this.fuelsupplier,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.person),
                    labelText: '  Fuel Supplier',
                  ),
                ),
              ),
              SizedBox(height: 40),
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
              SizedBox(height: 40),
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
              SizedBox(height: 40),
              PhysicalShape(
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
                      createFul(
                        qty: qty.text,
                        rate: rate.text,
                        supplier: fuelsupplier.text,
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
    );
  }
}
