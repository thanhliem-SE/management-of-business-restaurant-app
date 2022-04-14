import 'package:flutter/material.dart';
import 'package:go_quick_app/components/custom_box_shadow.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/chi_tiet_thuc_pham.dart';
import 'package:go_quick_app/views/select_category/select_category_view_model.dart';
import 'package:provider/provider.dart';

class SelectCategoryView extends StatelessWidget {
  final int numCustomer;
  final int numTable;
  final int? maHoaDon;
  const SelectCategoryView(
      {Key? key,
      required this.numTable,
      required this.numCustomer,
      this.maHoaDon})
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
        backgroundColor: kPrimaryLightColor,
        title: const Text(
          'YÊU CẦU ĐẶT MÓN',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: size.height * 0.05,
          ),
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
                    int amount = _viewModel.getAmoutFoodOrder(index);
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                      color: Colors.blueGrey),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (amount > 0) {
                                      _viewModel.setAmoutFoodOrder(
                                          index, amount - 1);
                                    }
                                  },
                                  icon: Icon(Icons.remove_circle_outlined),
                                  color: (amount > 0)
                                      ? kPrimaryColor
                                      : Colors.blueGrey,
                                  iconSize: size.width * 0.07,
                                ),
                                Text(
                                  amount.toString(),
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (amount < item.soLuong) {
                                      _viewModel.setAmoutFoodOrder(
                                          index, amount + 1);
                                    }
                                  },
                                  icon: Icon(Icons.add_circle_outlined),
                                  color: (amount < item.soLuong)
                                      ? kPrimaryColor
                                      : Colors.blueGrey,
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
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Container(
                    color: Colors.white,
                    width: size.width * 0.5,
                    height: size.height * 0.05,
                    alignment: Alignment.center,
                    child: Text(
                      'Tổng tiền: ' +
                          _viewModel.getToTalPrice().toString() +
                          'đ',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Container(
                    color: Colors.black,
                    width: size.width * 0.5,
                    height: size.height * 0.06,
                    alignment: Alignment.center,
                    child: const Text(
                      'Đặt món',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
