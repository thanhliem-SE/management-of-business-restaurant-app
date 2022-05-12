import 'package:flutter/material.dart';
import 'package:go_quick_app/components/app_bar.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/nhan_vien.dart';
import 'package:go_quick_app/models/thong_bao.dart';
import 'package:go_quick_app/socket_view_model.dart';
import 'package:go_quick_app/views/home/home_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NotificationView extends StatelessWidget {
  final NhanVien nhanVien;

  const NotificationView({Key? key, required this.nhanVien}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    final socketViewModel = Provider.of<SocketViewModel>(context);

    List<ThongBao> listThongBao = viewModel.getListThongBao();

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Thông báo', actions: [
        IconButton(
            onPressed: () {
              viewModel.init();
            },
            icon: const Icon(Icons.refresh_sharp)),
        IconButton(
            onPressed: () {
              viewModel.updateDaXemThongBao();
            },
            icon: const Icon(Icons.checklist_rtl_sharp)),
      ]),
      body: ListView.builder(
        itemCount: listThongBao.length,
        itemBuilder: (context, index) {
          ThongBao thongBao = listThongBao[index];
          return Container(
            padding: const EdgeInsets.only(left: 5, right: 5, top: 15),
            width: size.width,
            decoration: BoxDecoration(
              color:
                  thongBao.daXem == false ? kPrimaryLightColor : Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          thongBao.daXem == false
                              ? Icons.notifications_active
                              : Icons.notifications_sharp,
                          color: kPrimaryColor,
                          size: 30,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.7,
                              child: Text(
                                thongBao.noiDung!,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                maxLines: 5,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          DateFormat("HH:mm").format(thongBao!.createdAt!),
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        )
                      ],
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 1,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
