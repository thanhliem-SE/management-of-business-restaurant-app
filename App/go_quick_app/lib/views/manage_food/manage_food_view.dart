import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/chi_tiet_thuc_pham.dart';
import 'package:go_quick_app/models/danh_muc.dart';
import 'package:go_quick_app/models/thuc_pham.dart';
import 'package:go_quick_app/services/api_status.dart';
import 'package:go_quick_app/services/chi_tiet_thuc_pham_service.dart';
import 'package:go_quick_app/services/danh_muc_service.dart';
import 'package:go_quick_app/services/thuc_pham_service.dart';
import 'package:go_quick_app/utils/helper.dart';
import 'package:go_quick_app/views/manage_food/manage_food_view_model.dart';
import 'package:go_quick_app/views/select_category/components/list_view_food.dart';
import 'package:provider/provider.dart';

class ManageFoodView extends StatefulWidget {
  const ManageFoodView({Key? key}) : super(key: key);

  @override
  State<ManageFoodView> createState() => _ManageFoodViewState();
}

class _ManageFoodViewState extends State<ManageFoodView> {
  List<DanhMuc>? listDanhMuc;
  bool isLoading = false;
  int selectIndex = 0;
  late TextEditingController _soLuongController;
  @override
  void initState() {
    super.initState();
    _soLuongController = TextEditingController();
    isLoading = true;
    () async {
      await loadingDanhMucs();
      await loadingListThucPham();
      setState(() {
        isLoading = false;
      });
    }();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final viewModel = Provider.of<ManageFoodViewModel>(context);
    if (listDanhMuc != null) {
      viewModel.setDanhmucs(listDanhMuc);
    }
    return isLoading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
                strokeWidth: 2.0,
              ),
            ),
          )
        : DefaultTabController(
            length: listDanhMuc!.length,
            child: Scaffold(
              appBar: buildAppBar(size, context),
              body: Container(
                height: double.infinity,
                width: double.infinity,
                child: TabBarView(
                  children: [
                    for (var item in listDanhMuc!)
                      ListView.builder(
                        itemCount: item.thucphams!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.network(
                                            item.thucphams!
                                                .elementAt(index)
                                                .thucPham!
                                                .urlHinhAnh!
                                                .elementAt(0)
                                                .toString(),
                                            fit: BoxFit.cover,
                                            height: size.height * 0.1,
                                            width: size.width * 0.3,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Wrap(
                                              direction: Axis.vertical,
                                              children: [
                                                Text(
                                                  item.thucphams!
                                                      .elementAt(index)
                                                      .thucPham!
                                                      .ten
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Text(
                                                  item.thucphams!
                                                      .elementAt(index)
                                                      .thucPham!
                                                      .giaTien
                                                      .toString(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: size.width * 0.15,
                                          child: TextField(
                                            controller: _soLuongController,
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: kPrimaryColor,
                                                ),
                                              ),
                                              border: OutlineInputBorder(),
                                            ),
                                            cursorColor: kPrimaryColor,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                  ],
                ),
              ),
            ),
          );
  }

  AppBar buildAppBar(Size size, BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      bottom: TabBar(
        isScrollable: true,
        tabs: [
          for (var item in listDanhMuc!)
            Tab(
              text: item.loaiDanhMuc,
            )
        ],
      ),
      title: const Text(
        'Quản Lý Món Ăn',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: size.height * 0.05,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Future<void> loadingDanhMucs() async {
    try {
      String token = await Helper.getToken();
      var response = await DanhMucService().getDanhSachDanhMuc(token);
      if (response is Success) {
        listDanhMuc = response.response as List<DanhMuc>;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Lỗi lấy danh sách danh mục")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
  }

  Future<void> loadingListThucPham() async {
    try {
      List<ChiTietThucPham> chitietthucphams;
      String token = await Helper.getToken();
      var response =
          await ChiTietThucPhamService().getChiTietThucPhamHomNay(token);
      if (response is Success) {
        chitietthucphams = response.response as List<ChiTietThucPham>;
        if (chitietthucphams.isNotEmpty && chitietthucphams.length > 0) {
          for (var danhmuc in listDanhMuc!) {
            danhmuc.thucphams = [];
            danhmuc.thucphams!.addAll(chitietthucphams.where(
                (x) => x.thucPham!.danhMuc!.maDanhMuc == danhmuc.maDanhMuc));
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Lỗi lấy danh sách thực phẩm")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error: ${e.toString()}")));
    }
  }
}
