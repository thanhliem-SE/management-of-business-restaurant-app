import 'package:flutter/material.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/nhan_vien.dart';
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
          // ListTile(
          //   leading: const Icon(
          //     Icons.person,
          //     color: kPrimaryColor,
          //   ),
          //   title: const Text(
          //     'Thông tin cá nhân',
          //     style: TextStyle(color: kPrimaryColor),
          //   ),
          //   onTap: () => null,
          // ),
          ListTile(
            leading: const Icon(
              Icons.password_rounded,
              color: kPrimaryColor,
            ),
            title: const Text(
              'Đổi mật khẩu',
              style: TextStyle(color: kPrimaryColor),
            ),
            onTap: () => null,
          ),
          ListTile(
            title:
                const Text('Đăng xuất', style: TextStyle(color: kPrimaryColor)),
            leading: const Icon(Icons.logout, color: kPrimaryColor),
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
