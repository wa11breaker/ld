import 'package:shared_preferences/shared_preferences.dart';

class Sp {
  checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('logined') ?? false;
  }

  checkOnWork() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onwork') ?? false;
  }

  getDriverId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('driverid') ?? '';
  }

  getTripId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('tripid') ?? '';
  }

  checkAllCardState() async {
    List<dynamic> savedBool = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool siteGateIn = await prefs.getBool('siteGateIn') ?? false;
    bool siteGateOut = await prefs.getBool('siteGateOut') ?? false;
    bool portGateIn = await prefs.getBool('portGateIn') ?? false;
    bool portGateOut = await prefs.getBool('portGateOut') ?? false;

    savedBool.add(siteGateIn);
    savedBool.add(siteGateOut);
    savedBool.add(portGateIn);
    savedBool.add(portGateOut);

    return savedBool;
  }

  resetAllCardState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getKeys();
    for (String key in prefs.getKeys()) {
      if (key != "logined" && key != "driverid") {
        prefs.remove(key);
      }
    }
  }

  savCard(name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(name, true);
  }

  workDone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('onwork', false);
  }

  saveString(name, val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(name, val);
  }
}
