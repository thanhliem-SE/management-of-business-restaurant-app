import 'package:flutter/material.dart';
import 'package:go_quick_app/components/app_bar.dart';
import 'package:go_quick_app/components/custom_box_shadow.dart';
import 'package:go_quick_app/components/rounded_button.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/ban.dart';
import 'package:go_quick_app/models/chi_tiet_thuc_pham.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/bill/bill_view.dart';
import 'package:go_quick_app/views/request_order/component/select_table_count.dart';
import 'package:go_quick_app/views/request_order/request_order_view_model.dart';
import 'package:go_quick_app/views/select_category/select_category_view.dart';
import 'package:provider/provider.dart';

class RequestOrderView extends StatelessWidget {
  const RequestOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RequestOrderViewModel>(context);
    Size size = MediaQuery.of(context).size;

    if (viewModel.getIsInit() == false) {
      viewModel.init();
    }

    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: 'Yêu Cầu Đặt Món',
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => (SelectTableCount()),
              );
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
              size: size.height * 0.05,
            ),
          ),
          IconButton(
            onPressed: () {
              viewModel.init();
            },
            icon: Icon(
              Icons.refresh_sharp,
              color: Colors.white,
              size: size.height * 0.04,
            ),
          ),
        ],
        viewModel: viewModel,
      ),
      body: Container(
        color: kPrimaryLightColor,
        child: Column(
          children: [
            SizedBox(height: size.height * 0.03),
            Text('DANH SÁCH BÀN ĂN',
                style: TextStyle(
                    fontSize: size.height * 0.03,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            Expanded(
              child: (viewModel.getListBan().length > 0)
                  ? GridView.builder(
                      primary: false,
                      padding: const EdgeInsets.all(20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: viewModel.getListBan().length,
                      itemBuilder: (BuildContext context, int index) {
                        return cardTableOrder(
                            size: size,
                            context: context,
                            ban: viewModel.getListBan()[index],
                            viewModel: viewModel);
                      },
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}

Container cardTableOrder(
    {required Size size,
    required BuildContext context,
    required Ban ban,
    required RequestOrderViewModel viewModel}) {
  return Container(
    padding: const EdgeInsets.all(8),
    margin: const EdgeInsets.symmetric(horizontal: 5),
    decoration: BoxDecoration(
      boxShadow: [
        customBoxShadow(color: Colors.grey),
      ],
      color: ban.tinhTrang == null ? Colors.white : kPrimaryColor,
      border: Border.all(
        color: Colors.blueGrey,
        width: 2,
      ),
    ),
    child: InkWell(
      onTap: () {
        if (ban.tinhTrang != null) {
          viewModel.showHoaDon(maSoBan: ban.maSoBan!, context: context);
        }
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                ban.viTri.toString(),
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color:
                        ban.tinhTrang == null ? kPrimaryColor : Colors.white),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ban.tinhTrang == null ? 'Trống' : 'Phục Vụ',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color:
                        ban.tinhTrang == null ? kPrimaryColor : Colors.white),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
