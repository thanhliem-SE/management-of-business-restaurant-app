import 'package:flutter/material.dart';
import 'package:go_quick_app/components/custom_box_shadow.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/ban.dart';
import 'package:provider/provider.dart';

import 'components/add_table_dialog.dart';
import 'components/remove_table_dialog.dart';
import 'manage_table_view_model.dart';

class ManageTableView extends StatelessWidget {
  const ManageTableView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final viewModel = Provider.of<ManageTableViewModel>(context);

    if (viewModel.getIsInit() == false) {
      viewModel.init();
    }

    List<Ban> listBanTangTret = viewModel.getListBanByViTri('Tầng Trệt');
    List<Ban> listBanTang1 = viewModel.getListBanByViTri('Tầng 1');

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: buildAppBar(size, context, viewModel),
        body: TabBarView(children: [
          Container(
            color: kPrimaryLightColor,
            child: (listBanTangTret.length > 0)
                ? GridView.builder(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: listBanTangTret.length,
                    itemBuilder: (BuildContext context, int index) {
                      return cardTableOrder(
                          size: size,
                          context: context,
                          ban: listBanTangTret[index],
                          viewModel: viewModel);
                    },
                  )
                : Container(),
          ),
          Container(
            color: kPrimaryLightColor,
            child: (listBanTang1.length > 0)
                ? GridView.builder(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: listBanTang1.length,
                    itemBuilder: (BuildContext context, int index) {
                      return cardTableOrder(
                          size: size,
                          context: context,
                          ban: listBanTang1[index],
                          viewModel: viewModel);
                    },
                  )
                : Container(),
          ),
        ]),
      ),
    );
  }

  AppBar buildAppBar(
      Size size, BuildContext context, ManageTableViewModel viewModel) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      actions: [
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const RemoveTableDialog(),
            );
          },
          icon: const Icon(Icons.remove_circle_outline_outlined),
        ),
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const AddTableDialog(),
            );
          },
          icon: const Icon(Icons.add_circle_outline_rounded),
        ),
        IconButton(
            onPressed: () {
              viewModel.init();
            },
            icon: const Icon(Icons.refresh))
      ],
      bottom: const TabBar(
        tabs: [
          Tab(
            text: 'Tầng Trệt',
            icon: Icon(Icons.home),
          ),
          Tab(
            text: 'Tầng 1',
            icon: Icon(Icons.home_work_sharp),
          ),
        ],
      ),
      title: const Text(
        'Quản Lý Bàn',
        style: TextStyle(color: Colors.white),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: size.height * 0.05,
        ),
        onPressed: () {
          Navigator.pop(context);
          viewModel.clear();
        },
      ),
    );
  }

  Container cardTableOrder(
      {required Size size,
      required BuildContext context,
      required Ban ban,
      required ManageTableViewModel viewModel}) {
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
        onTap: () {},
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  ban.soBan.toString(),
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
                      fontSize: 16,
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
}
