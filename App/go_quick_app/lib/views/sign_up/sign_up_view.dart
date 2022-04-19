import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_quick_app/views/sign_up/components/elevated_button_rounded.dart';

import 'package:go_quick_app/views/sign_up/components/text_field_signup_component.dart';
import 'package:go_quick_app/views/sign_up/components/text_password_component.dart';
import 'package:go_quick_app/views/sign_up/sign_up_viewmodel.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpViewModel>(context);
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/logo.png",
                            width: constraints.maxWidth * 0.3,
                          ),
                          Column(
                            children: const [
                              Text(
                                "Go Quick",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text("Ẩm thực là tinh hoa cuộc sống")
                            ],
                          )
                        ],
                      ),
                    ),
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
                  width: constraints.maxWidth * 0.9,
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
                          TextFieldSignUp(
                            hintText: "Họ và Tên",
                            onChanged: (String value) {
                              provider.setTenKhachHang = value;
                            },
                          ),
                          TextFieldSignUp(
                            hintText: "Số điện thoại",
                            onChanged: (String value) {
                              provider.setSoDienthoai = value;
                            },
                          ),
                          TextFieldSignUp(
                            hintText: "Tên tài khoản",
                            onChanged: (value) {
                              provider.setTenTaikhoan = value;
                            },
                          ),
                          TextInputPassword(
                            hintPass: "Mật khẩu",
                            onChanged: (value) {
                              provider.setMatKhau = value;
                            },
                          ),
                          TextInputPassword(
                            hintPass: "Nhập lại Mật khẩu",
                            onChanged: (value) {
                              provider.setNhapLaiMatKhau = value;
                            },
                          ),
                          ElevatedButtonRouded(
                            text: "Sign Up",
                            constraints: constraints,
                            onPressed: () {
                              provider.SignUp(context);
                            },
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
