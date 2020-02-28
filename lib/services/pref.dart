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

  checkAllCardState() async {
    List<dynamic> hai = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool a = await prefs.getBool('a') ?? false;
    bool b = await prefs.getBool('b') ?? false;
    bool c = await prefs.getBool('c') ?? false;
    bool d = await prefs.getBool('d') ?? false;
    bool aa = await prefs.getBool('aa') ?? false;
    bool bb = await prefs.getBool('bb') ?? false;
    bool cc = await prefs.getBool('cc') ?? false;
    bool dd = await prefs.getBool('dd') ?? false;
    bool next = await prefs.getBool('next') ?? false;
    int index = await prefs.getInt('index') ?? 0;
    hai.add(a);
    hai.add(b);
    hai.add(c);
    hai.add(d);
    hai.add(aa);
    hai.add(bb);
    hai.add(cc);
    hai.add(dd);
    hai.add(next);
    hai.add(index);
    return hai;
  }

  resetAllCardState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('a', false);
    prefs.setBool('b', false);
    prefs.setBool('c', false);
    prefs.setBool('d', false);
    prefs.setBool('aa', false);
    prefs.setBool('bb', false);
    prefs.setBool('cc', false);
    prefs.setBool('dd', false);
    prefs.setBool('next', false);
    prefs.setInt('index', 0);
  }

  savCard(name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(name, true);
  }

  savIndex(name, val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(name, val);
  }

  workDone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('onwork', false);
  }
}
