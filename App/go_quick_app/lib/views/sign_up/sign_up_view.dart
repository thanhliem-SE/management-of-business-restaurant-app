import 'package:flutter/material.dart';
import 'package:go_quick_app/views/sign_up/components/elevated_button_rounded.dart';

import 'package:go_quick_app/views/sign_up/components/text_field_signup_component.dart';
import 'package:go_quick_app/views/sign_up/components/text_password_component.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                decoration: const BoxDecoration(color: Colors.deepOrange),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: constraints.maxHeight * 0.7,
                      width: constraints.maxWidth,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.elliptical(200, 100),
                          topRight: Radius.elliptical(200, 100),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  width: constraints.maxWidth * 0.8,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Pacificos'),
                          ),
                          const TextFieldSignUp(
                            hintText: "Họ và Tên",
                          ),
                          const TextFieldSignUp(
                            hintText: "Số điện thoại",
                          ),
                          const TextFieldSignUp(
                            hintText: "Tên tài khoản",
                          ),
                          const TextInputPassword(
                            hintPass: "Mật khẩu",
                          ),
                          const TextInputPassword(
                            hintPass: "Nhập lại Mật khẩu",
                          ),
                          ElevatedButtonRouded(
                            text: "Sign Up",
                            constraints: constraints,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Bạn đã có tài khoản? Hãy đăng nhập",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
