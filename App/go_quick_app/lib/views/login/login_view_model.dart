import 'package:flutter/material.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/login_service.dart';
import 'package:go_quick_app/utils/helper.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/home/home_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends ChangeNotifier {
  String _username = '';
  String _password = '';
  bool _loading = false;
  String _token = '';
  bool _isHidePass = true;

  setIsHidePass(bool value) {
    _isHidePass = value;
    notifyListeners();
  }

  get isHidePass => this._isHidePass;

  String get username => this._username;

  get password => this._password;

  get loading => this._loading;

  get token => this._token;

  setUsername(String username) {
    _username = username;
  }

  setPassword(String password) {
    _password = password;
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setToken(String token) {
    _token = token;
    Helper.setToken(token);
  }

  login(context) async {
    setLoading(true);
    var response = await LoginService().login(_username, _password);
    if (response is Success) {
      setToken(response.response as String);
      NavigationHelper.push(context: context, page: HomeView());
    }
    if (response is Failure) {
      String errorResponse = (response as Failure).errrorResponse as String;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorResponse)));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
