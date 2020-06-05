import 'dart:async';
import 'package:LondonDollar/congif/constants.dart';
import 'package:LondonDollar/services/pref.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

startLocation() async {
  String vehicleid = await Sp().getVehiclerId();
  if (vehicleid != '') {
    sendLocation(vID: vehicleid);
    Timer.periodic(Duration(minutes: 20), (time) {
      sendLocation(vID: vehicleid);
    });
  }
}

sendLocation({String vID}) async {
  // print(vID);
  Position position = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);

  await Dio().post(
    api + "gps/create.php",
    data: {
      "vehicleid": vID,
      "latitude": position.latitude,
      "longitude": position.longitude,
    },
  );
  // .then((value) => print(value.statusCode.toString()));
}
