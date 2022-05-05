import 'package:flutter/material.dart';
import 'package:go_quick_app/components/rounded_button.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/manage_table/manage_table_view_model.dart';
import 'package:go_quick_app/views/request_order/request_order_view_model.dart';
import 'package:go_quick_app/views/select_category/select_category_view.dart';
import 'package:provider/provider.dart';

class RemoveTableDialog extends StatelessWidget {
  const RemoveTableDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final viewModel = Provider.of<ManageTableViewModel>(context);
    return AlertDialog(
      title: const Text(
        'DANH SÁCH BÀN TRỐNG',
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/icon_table.png',
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Container(
              width: size.width,
              height: size.height * 0.38,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                ),
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      if (viewModel.getListRemoveTable().contains(index + 1)) {
                        viewModel.removeRemoveTable(index + 1);
                      } else {
                        viewModel.addRemoveTable(index + 1);
                      }
                    },
                    child: Card(
                      color: viewModel.getListRemoveTable().contains(index + 1)
                          ? kPrimaryColor
                          : kPrimaryLightColor,
                      child: Center(
                          child: Text(
                        (index + 1).toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: viewModel
                                    .getListRemoveTable()
                                    .contains(index + 1)
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
                NavigationHelper.push(
                    context: context, page: SelectCategoryView());
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
