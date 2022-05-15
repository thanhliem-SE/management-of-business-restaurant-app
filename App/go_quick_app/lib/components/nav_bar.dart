import 'package:flutter/material.dart';
import 'package:go_quick_app/components/rounded_button.dart';
import 'package:go_quick_app/components/rounded_password_field.dart';
import 'package:go_quick_app/components/show_alert_dialog.dart';
import 'package:go_quick_app/models/nhan_vien.dart';
import 'package:go_quick_app/models/tai_khoan.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/tai_khoan_service.dart';
import 'package:go_quick_app/utils/helper.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/login/login_view.dart';

class NavBar extends StatelessWidget {
  final NhanVien nhanVien;
  const NavBar({
    Key? key,
    required this.nhanVien,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              nhanVien.tenNhanVien!,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
              nhanVien.taiKhoan!.quyen!,
              style: const TextStyle(color: Colors.white),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8hQCe_BFN9p7BvUCZC4UQYFMyqvWXme86WA&usqp=CAU',
                  fit: BoxFit.fill,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.password_rounded,
            ),
            title: const Text(
              'Đổi mật khẩu',
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) => ConfirmPasswordDialog(
                        taiKhoan: nhanVien.taiKhoan!,
                      ));
            },
          ),
          ListTile(
            title: const Text(
              'Đăng xuất',
            ),
            leading: const Icon(Icons.logout),
            onTap: () => {
              Helper.setToken(''),
              NavigationHelper.pushReplacement(
                  context: context, page: const LoginView())
            },
          ),
        ],
      ),
    );
  }
}

class ConfirmPasswordDialog extends StatelessWidget {
  final TaiKhoan taiKhoan;
  const ConfirmPasswordDialog({Key? key, required this.taiKhoan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var matKhauCu = '';
    var matKhauCheck = '';
    var matKhauMoi = '';
    return AlertDialog(
      title: const Text(
        'Đổi mật khẩu',
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            RoundedPasswordField(
              onChanged: (value) {
                matKhauCu = value;
              },
              hintText: 'Nhập mật khẩu cũ',
            ),
            RoundedPasswordField(
              onChanged: (value) {
                matKhauMoi = value;
              },
              hintText: 'Nhập mật khẩu mới',
            ),
            RoundedPasswordField(
              onChanged: (value) {
                matKhauCheck = value;
              },
              hintText: 'Xác nhận mật khẩu mới',
            ),
            RoundedButton(
              text: 'Xác nhận',
              press: () {
                if (matKhauMoi == matKhauCheck) {
                  doiTaiKhoan(context, taiKhoan, matKhauCu, matKhauMoi);
                } else {
                  showAlertDialog(
                      context: context,
                      title: 'Thất bại',
                      message: 'Mật khẩu mới và xác nhận không khớp');
                }
              },
            )
          ],
        ),
      ),
    );
  }

  doiTaiKhoan(BuildContext context, TaiKhoan taiKhoan, String matKhauCu,
      String matKhauMoi) async {
    String token = await Helper.getToken();
    final response = await TaiKhoanService()
        .doiMatKhau(token, taiKhoan.tenTaiKhoan!, matKhauCu, matKhauMoi);
    if (response is Success) {
      NavigationHelper.push(context: context, page: const LoginView());
      showAlertDialog(
          context: context,
          title: 'Thành công',
          message: 'Đổi mật khẩu thành công');
    } else {
      Navigator.pop(context);
      showAlertDialog(
          context: context,
          title: 'Thất bại',
          message: 'Đổi mật khẩu thất bại');
    }
  }
}
