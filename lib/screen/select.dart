import 'package:flutter/material.dart';
import 'package:LondonDollar/screen/home.dart';
import 'package:flutter/rendering.dart';

class Select extends StatefulWidget {
  @override
  _SelectState createState() => _SelectState();
}

class _SelectState extends State<Select> {
  String number;

  String target;

  List<String> _locations = [
    'Thiruvananthapuram',
    'Kochi',
    'kozhikode',
    'Kollam'
  ]; // Option 2
  String _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter licence plate number',
                  ),
                  onChanged: (text) {
                    number = text;
                  },
                ),
                SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  child: DropdownButton(
                    hint: Text('Choose a location'),
                    value: _selectedLocation,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedLocation = newValue;
                      });
                    },
                    items: _locations.map((location) {
                      return DropdownMenuItem(
                        child: new Text(location),
                        value: location,
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 60),
                FlatButton(
                  color: Colors.green,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
