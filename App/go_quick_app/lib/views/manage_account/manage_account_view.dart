import 'package:flutter/material.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/nhan_vien.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/home/home_view.dart';
import 'package:go_quick_app/views/manage_account/component/form_add_account_view.dart';
import 'package:go_quick_app/views/manage_account/manage_account_view_model.dart';
import 'package:provider/provider.dart';

class ManageAccountView extends StatelessWidget {
  const ManageAccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final viewModel = Provider.of<ManageAccountViewModel>(context);
    if (viewModel.initialized) {
      return DefaultTabController(
        length: viewModel.quyenList.length,
        child: WillPopScope(
          onWillPop: () async {
            viewModel.clear();
            Navigator.of(context).pop();
            return true;
          },
          child: Scaffold(
            appBar: buildAppBar(size, context, viewModel),
            body: TabBarView(
              children: [
                for (var item in viewModel.quyenList)
                  RefreshIndicator(
                    color: kPrimaryColor,
                    onRefresh: () async {
                      await viewModel.Initialied(context);
                    },
                    child: ListView.builder(
                      itemCount: item.nhanViens.length,
                      itemBuilder: (context, index) {
                        NhanVien nhanvien = item.nhanViens[index];
                        return Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: LayoutBuilder(
                                  builder: (BuildContext context,
                                      BoxConstraints constraints) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.account_box_sharp,
                                        size: constraints.maxWidth,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      child: Text(
                                        nhanvien.tenNhanVien ?? "",
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ),
                                    SizedBox(
                                      child: Text(
                                        'Quyền: ${nhanvien.taiKhoan?.quyen}',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(
                                      child: Text(
                                        'Sđt: ${nhanvien.soDienThoai}',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(
                                      child: Text(
                                        'Tên tài khoản: ${nhanvien.taiKhoan?.tenTaiKhoan}',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              nhanvien.taiKhoan?.quyen != "QUANLY"
                                  ? Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.red),
                                          onPressed: () async {
                                            await viewModel.xoaNhanVien(
                                                context, nhanvien);
                                          },
                                          child: Text("Xóa"),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    } else {
      viewModel.Initialied(context);
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: kPrimaryColor,
            strokeWidth: 2.0,
          ),
        ),
      );
    }
  }

  AppBar buildAppBar(
      Size size, BuildContext context, ManageAccountViewModel viewModel) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      bottom: TabBar(
        isScrollable: true,
        tabs: [
          for (var item in viewModel.quyenList)
            Tab(
              text: item.quyen,
            )
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {
              NavigationHelper.pushReplacement(
                  context: context, page: const FormAddAccountView());
            },
            icon: Icon(Icons.add_box_rounded))
      ],
      title: Column(
        children: [
          Text(
            'Quản lý tài khoản',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          viewModel.clear();
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
