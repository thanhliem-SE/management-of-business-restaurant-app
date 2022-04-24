import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_quick_app/components/nav_bar.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/nhan_vien.dart';
import 'package:go_quick_app/models/tai_khoan.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/nhan_vien_service.dart';
import 'package:go_quick_app/utils/helper.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/home/home_view_model.dart';
import 'package:go_quick_app/views/request_order/request_order_view.dart';
import 'package:go_quick_app/views/welcome/welcome_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late TaiKhoan taiKhoan;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    final future = viewModel.getTaiKhoan(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          title: Text(
            'GoQuick',
          ),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          ]),
      body: FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            taiKhoan = snapshot.data as TaiKhoan;
            storedSignedData(taiKhoan);
            if (taiKhoan.quyen == 'ADMIN') {
              return WidgetForAdmin();
            }
            return Container();
          } else {
            return WelcomeView();
          }
        },
      ),
      drawer: NavBar(),
    );
  }

  void storedSignedData(TaiKhoan taiKhoan) async {
    Helper.setTaiKhoanSigned(taiKhoan);
    String token = await Helper.getToken();

    var response = await NhanVienService()
        .getNhanVienByTenTaiKhoan(token, taiKhoan.tenTaiKhoan!);
    if (response is Success) {
      NhanVien nhanVien = response.response as NhanVien;
      Helper.setNhanVienSigned(nhanVien);
    }
  }
}

class WidgetForAdmin extends StatelessWidget {
  const WidgetForAdmin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        cardItemMenu(size, Icons.app_registration_outlined, 'Yêu cầu đặt món',
            Colors.lightGreen, () {
          NavigationHelper.push(
              context: context,
              page: const RequestOrderView(),
              routeName: 'RequestOrderView');
        }),
        cardItemMenu(size, Icons.library_books, 'Tiếp nhận đặt món',
            Colors.pinkAccent, () {}),
        cardItemMenu(size, Icons.manage_accounts, 'Quản lý tài khoản',
            Colors.lightBlueAccent, () {}),
        cardItemMenu(
            size, Icons.person, 'Quản lý khách hàng', Colors.limeAccent, () {}),
        cardItemMenu(size, Icons.restaurant, 'Quản lý món ăn',
            Colors.orangeAccent, () {}),
        cardItemMenu(size, Icons.home_repair_service_outlined,
            'Quản lý nguyên liệu', Colors.purpleAccent, () {}),
        cardItemMenu(size, Icons.bar_chart_outlined, 'Thống kê',
            Colors.indigoAccent, () {}),
        cardItemMenu(
            size, Icons.logout_outlined, 'Đăng xuất', Colors.redAccent, () {}),
      ],
    );
  }

  InkWell cardItemMenu(
      Size size, IconData icon, String title, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: size.height * 0.08,
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        color: color,
      ),
    );
  }
}
