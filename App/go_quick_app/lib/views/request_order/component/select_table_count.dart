import 'package:flutter/material.dart';
import 'package:go_quick_app/components/rounded_button.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/ban.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/request_order/request_order_view_model.dart';
import 'package:go_quick_app/views/select_category/select_category_view.dart';
import 'package:provider/provider.dart';

class SelectTableCount extends StatelessWidget {
  const SelectTableCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final viewModel = Provider.of<RequestOrderViewModel>(context);
    List<Ban> listBanTrong =
        viewModel.getListBan().where((ban) => ban.tinhTrang == null).toList();
    return AlertDialog(
      title: const Text(
        'DANH SÁCH BÀN TRỐNG',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/icon_table.png',
                  color: kPrimaryColor,
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Container(
              width: size.width,
              height: size.height * 0.38,
              alignment: Alignment.center,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                ),
                itemCount: listBanTrong.length,
                itemBuilder: (BuildContext context, int index) {
                  Ban ban = listBanTrong[index];
                  return InkWell(
                    onTap: () {
                      viewModel.setNumTable(ban.maSoBan!);
                    },
                    child: Card(
                      color: viewModel.getNumTable() == ban.maSoBan
                          ? kPrimaryColor
                          : kPrimaryLightColor,
                      child: Center(
                          child: Text(
                        ban.viTri.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: viewModel.getNumTable() == ban.maSoBan
                                ? Colors.white
                                : Colors.black),
                      )),
                    ),
                  );
                },
              ),
            ),
            RoundedButton(
              text: 'TIẾP THEO',
              press: () {
                NavigationHelper.push(
                    context: context, page: SelectCategoryView());
              },
              color: kPrimaryColor,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
