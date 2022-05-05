import 'package:flutter/material.dart';
import 'package:go_quick_app/components/rounded_button.dart';
import 'package:go_quick_app/components/rounded_input_field.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/chi_tiet_thuc_pham.dart';
import 'package:go_quick_app/models/thuc_pham.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/request_order/request_order_view_model.dart';
import 'package:go_quick_app/views/select_category/components/list_view_food.dart';
import 'package:go_quick_app/views/select_category/select_category_view.dart';
import 'package:provider/provider.dart';

class SearchOrderDialog extends StatelessWidget {
  const SearchOrderDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AlertDialog(
      title: const Text(
        'TÌM KIẾM HÓA ĐƠN',
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            RoundedInputField(
              hintText: 'Nhập mã hóa đơn',
              onChanged: (value) {},
              icon: Icons.search,
            ),
            SizedBox(
              height: size.height * 0.5,
              width: size.width,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Hóa đơn #001',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Icon(Icons.done_all_rounded,
                            color: Colors.green, size: 30),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network(
                            'https://statics.vinpearl.com/com-tam-ngon-o-sai-gon-0_1630562640.jpg',
                            fit: BoxFit.cover,
                            width: size.width * 0.2,
                            height: size.height * 0.1,
                          ),
                          const Text(
                            'Com tấm',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text('x2'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network(
                            'https://nghethuat365.com/wp-content/uploads/2021/08/Cach-Nau-Canh-Chua-Ca-Loc-Don-Gian-Ma-Ngon.jpg',
                            fit: BoxFit.fill,
                            width: size.width * 0.2,
                            height: size.height * 0.1,
                          ),
                          SizedBox(
                            width: size.width * 0.25,
                            child: const Text(
                              'Canh chua cá lóc',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Text('x1'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
