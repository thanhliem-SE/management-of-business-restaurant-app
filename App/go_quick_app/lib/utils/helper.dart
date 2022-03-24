import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  static Future<bool> isHasToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (prefs.getString('token') != '') {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String token = prefs.getString('token')!;
      if (token != '') {
        return token;
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  static setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }
}
