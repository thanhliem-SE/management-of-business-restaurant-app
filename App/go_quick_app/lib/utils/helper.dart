import 'package:shared_preferences/shared_preferences.dart';

Future<bool> checkLogin() async {
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

getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    String token = prefs.getString('token')!;
    if (token != '') {
      return token;
    }
    return null;
  } catch (e) {
    return null;
  }
}

setToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token', token);
}
