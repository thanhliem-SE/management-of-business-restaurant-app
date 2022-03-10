import 'package:flutter/material.dart';
import 'package:go_quick_app/services/login_service.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/home/home_view.dart';

class LoginViewModel {
  late String _username;
  late String _password;

  setUsername(String username) {
    _username = username;
  }

  setPassword(String password) {
    _password = password;
  }

  getUsername() {
    return _username;
  }

  getPassword() {
    return _password;
  }

  login(context) async {
    final future = LoginService().login(_username, _password);
    future.then((value) {
      String token = value;
      NavigationHelper.push(context: context, page: HomeView());
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tên tài khoản/mật khẩu không đúng')));
    });
  }
}
