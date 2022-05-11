import 'package:flutter/material.dart';
import 'package:go_quick_app/components/app_bar.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/nhan_vien.dart';
import 'package:go_quick_app/socket_view_model.dart';
import 'package:provider/provider.dart';

class NotificationView extends StatelessWidget {
  final NhanVien nhanVien;

  const NotificationView({Key? key, required this.nhanVien}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final socketViewModel = Provider.of<SocketViewModel>(context);
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Thông báo', actions: [
        IconButton(
            onPressed: () {
              socketViewModel.sendMessage('CHEBIEN', 'hoa don moi');
            },
            icon: const Icon(Icons.checklist_rtl_sharp))
      ]),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5, right: 5, top: 15),
            width: size.width,
            decoration: BoxDecoration(
              color: kPrimaryLightColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.notifications_active,
                          color: kPrimaryColor,
                          size: 30,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.7,
                              child: const Text(
                                'Nhận yêu cầu đặt món mới cần chế biến',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                maxLines: 5,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          '11:35',
                          style: TextStyle(fontStyle: FontStyle.italic),
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
          ),
        ],
      ),
    );
  }
}
