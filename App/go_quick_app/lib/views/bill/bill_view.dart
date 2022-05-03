import 'package:flutter/material.dart';
import 'package:go_quick_app/components/app_bar.dart';
import 'package:go_quick_app/components/rounded_button.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:intl/intl.dart';

class BillView extends StatelessWidget {
  final int maHoaDon;

  const BillView({Key? key, required this.maHoaDon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(
          context: context,
          title: 'Hóa đơn #' + maHoaDon.toString(),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.add),
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildTextSpan(
                    boldText: 'Trạng thái: ', normalText: 'chờ tiếp nhận'),
                buildTextSpan(
                    boldText: 'Thời gian: ', normalText: '02 May 20:12'),
              ],
            ),
            Container(
              width: size.width,
              margin: EdgeInsets.only(top: 10),
              child: buildTextSpan(
                  boldText: 'Người lập hóa đơn: ',
                  normalText: 'Nguyễn Thanh Liêm'),
            ),
            Container(
              width: size.width,
              margin: EdgeInsets.only(top: 10),
              child: buildTextSpan(
                  boldText: 'Người chế biến: ', normalText: 'Đoàn Văn Vĩnh'),
            ),
            Container(
              width: size.width,
              margin: EdgeInsets.only(top: 10),
              child: buildTextSpan(
                  boldText: 'Hình thức thanh toán: ', normalText: 'tiền mặt'),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              padding: const EdgeInsets.all(5.0),
              width: size.width,
              color: Colors.blueGrey[50],
              child: const Text(
                'Danh Sách Đặt Món - Bàn 11',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(
                    'https://statics.vinpearl.com/com-tam-ngon-o-sai-gon-0_1630562640.jpg',
                    width: size.width * 0.2,
                    height: size.height * 0.1,
                    fit: BoxFit.fill,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: size.width * 0.3,
                        child: const Text(
                          'Cơm tấm',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      SizedBox(
                        width: size.width * 0.3,
                        child: Text(
                          NumberFormat('###,###').format(30000) + 'đ',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.blueGrey),
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'x2',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(width: size.width * 0.2),
                  Text(
                    NumberFormat('###,###').format(60000) + 'đ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(
                    'https://filebroker-cdn.lazada.vn/kf/S7f8ed4d038d743d4852ab22504a211f8K.jpg',
                    width: size.width * 0.2,
                    height: size.height * 0.1,
                    fit: BoxFit.fill,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: size.width * 0.3,
                        child: const Text(
                          'Lon CocaCola',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      SizedBox(
                        width: size.width * 0.3,
                        child: Text(
                          NumberFormat('###,###').format(10000) + 'đ',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.blueGrey),
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'x2',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(width: size.width * 0.2),
                  Text(
                    NumberFormat('###,###').format(20000) + 'đ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tổng tiền',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(NumberFormat('###,###').format(80000) + 'đ',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        color: kPrimaryColor,
                        width: size.width * 0.9,
                        height: size.height * 0.05,
                        alignment: Alignment.center,
                        child: const Text(
                          'Thanh Toán',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        color: Colors.redAccent[700],
                        width: size.width * 0.9,
                        height: size.height * 0.05,
                        alignment: Alignment.center,
                        child: const Text(
                          'Hủy',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildTextSpan({required String boldText, required String normalText}) {
    return RichText(
        text: TextSpan(
      text: boldText,
      style: const TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
      children: <TextSpan>[
        TextSpan(
            text: normalText,
            style: const TextStyle(fontWeight: FontWeight.normal)),
      ],
    ));
  }
}
