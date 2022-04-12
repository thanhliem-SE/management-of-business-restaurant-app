import 'package:flutter/material.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/chi_tiet_thuc_pham.dart';
import 'package:go_quick_app/views/select_category/select_category_view_model.dart';
import 'package:provider/provider.dart';

class SelectCategoryView extends StatelessWidget {
  final int numCustomer;
  final int numTable;
  const SelectCategoryView(
      {Key? key, required this.numTable, required this.numCustomer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<SelectCategoryViewModel>(context);

    if (!_viewModel.getIsInit()) {
      _viewModel.init();
    }

    List<ChiTietThucPham> listChiTietThucPhamHomNay =
        _viewModel.getListChiTietThucPham();

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('YÊU CẦU ĐẶT MÓN'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: kPrimaryLightColor,
      body: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: size.width * 0.05),
              color: Colors.white,
              width: size.width * 0.9,
              height: size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people,
                    color: kPrimaryColor,
                    size: size.width * 0.1,
                  ),
                  SizedBox(width: size.width * 0.01),
                  Text(
                    '$numCustomer',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(width: size.width * 0.3),
                  Icon(
                    Icons.chair,
                    color: kPrimaryColor,
                    size: size.width * 0.1,
                  ),
                  SizedBox(width: size.width * 0.01),
                  Text(
                    '$numTable',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          Text(
              listChiTietThucPhamHomNay.length.toString() + ' món ăn sẵn sàng'),
          listChiTietThucPhamHomNay.length > 0
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: listChiTietThucPhamHomNay.length,
                  padding: EdgeInsets.all(size.width * 0.05),
                  itemBuilder: (BuildContext context, int index) {
                    ChiTietThucPham item = listChiTietThucPhamHomNay[index];
                    return Expanded(
                      child: Container(
                        padding: EdgeInsets.all(size.width * 0.02),
                        color: Colors.white,
                        width: size.width * 1,
                        height: size.height * 0.15,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.network(
                              item.thucPham.urlHinhAnh[0],
                              fit: BoxFit.cover,
                              height: size.height * 0.1,
                              width: size.width * 0.2,
                            ),
                            SizedBox(width: size.width * 0.02),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  item.thucPham.ten,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                SizedBox(height: size.height * 0.01),
                                Text(
                                  item.thucPham.giaTien.toString() + 'đ',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.remove_circle_outlined),
                                  color: kPrimaryColor,
                                  iconSize: size.width * 0.07,
                                ),
                                Text(
                                  '1',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.add_circle_outlined),
                                  color: kPrimaryColor,
                                  iconSize: size.width * 0.07,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const Center(child: Text('Không có món ăn sẵn sàng')),
        ],
      ),
    );
  }
}
