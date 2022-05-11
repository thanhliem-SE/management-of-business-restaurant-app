import 'package:flutter/material.dart';
import 'package:go_quick_app/components/rounded_button.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/ban.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/manage_table/manage_table_view_model.dart';
import 'package:go_quick_app/views/request_order/request_order_view_model.dart';
import 'package:go_quick_app/views/select_category/select_category_view.dart';
import 'package:provider/provider.dart';

class RemoveTableDialog extends StatelessWidget {
  const RemoveTableDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ManageTableViewModel>(context);
    List<Ban> listBanTrong =
        viewModel.getListBanByViTri(viewModel.getViTriBanThem());
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      title: const Text(
        'DANH SÁCH BÀN TRỐNG',
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton(
                  items: <String>['Tầng Trệt', 'Tầng 1']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    viewModel.setViTriBanThem(value.toString());
                  },
                  value: viewModel.getViTriBanThem(),
                  style: const TextStyle(color: Colors.black, fontSize: 18),
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
                      if (viewModel
                          .getListRemoveTable()
                          .contains(ban.maSoBan)) {
                        viewModel.removeRemoveTable(ban.maSoBan!);
                      } else {
                        viewModel.addRemoveTable(ban.maSoBan!);
                      }
                    },
                    child: Card(
                      color:
                          viewModel.getListRemoveTable().contains(ban.maSoBan)
                              ? kPrimaryColor
                              : kPrimaryLightColor,
                      child: Center(
                          child: Text(
                        ban.soBan.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: viewModel
                                    .getListRemoveTable()
                                    .contains(ban.maSoBan)
                                ? Colors.white
                                : Colors.black),
                      )),
                    ),
                  );
                },
              ),
            ),
            RoundedButton(
              text: 'XÓA BÀN',
              press: () {
                viewModel.deleteBan(context);
              },
              color: Colors.red,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
