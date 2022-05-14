import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_quick_app/components/already_have_an_account_acheck.dart';
import 'package:go_quick_app/components/rounded_button.dart';
import 'package:go_quick_app/components/rounded_input_field.dart';
import 'package:go_quick_app/components/rounded_password_field.dart';
import 'package:go_quick_app/components/show_alert_dialog.dart';
import 'package:go_quick_app/components/text_field_container.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/home/home_view.dart';
import 'package:go_quick_app/views/login/login_view_model.dart';
import 'package:go_quick_app/views/sign_up/sign_up_view.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        showConfirmDialog(context, () {
          SystemNavigator.pop();
        }, 'Bạn có xác nhận muốn thoát ứng dụng?');
        return true;
      },
      child: Scaffold(
        body: LoginBackground(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "GOQUICK",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: kPrimaryColor,
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Image.asset(
                    'assets/images/logo.png',
                    // color: kPrimaryColor,
                    height: size.height * 0.35,
                  ),
                  SizedBox(height: size.height * 0.03),
                  TextFieldContainer(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Tên tài khoản rỗng';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        viewModel.setUsername(value);
                      },
                      cursorColor: kPrimaryColor,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: kPrimaryColor,
                        ),
                        hintText: 'Tên tài khoản',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextFieldContainer(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Mật khẩu rỗng';
                        }
                        return null;
                      },
                      obscureText: viewModel.isHidePass,
                      onChanged: (value) {
                        viewModel.setPassword(value);
                      },
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        hintText: "Mật khẩu",
                        icon: const Icon(
                          Icons.lock,
                          color: kPrimaryColor,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              viewModel.setIsHidePass(!viewModel.isHidePass);
                            },
                            icon: const Icon(
                              Icons.visibility,
                              color: kPrimaryColor,
                            )),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  RoundedButton(
                    text: "ĐĂNG NHẬP",
                    press: () {
                      if (_formKey.currentState!.validate()) {
                        viewModel.login(context);
                      }
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginBackground extends StatelessWidget {
  final Widget child;
  const LoginBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_top.png",
              width: size.width * 0.35,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/login_bottom.png",
              width: size.width * 0.4,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
