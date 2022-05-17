import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/thuc_pham.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/food_detail/food_detail_view_model.dart';
import 'package:go_quick_app/views/home/home_view.dart';
import 'package:go_quick_app/views/manage_food/manage_all_food_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailFoodView extends StatelessWidget {
  final ThucPham thucPham;
  const DetailFoodView({Key? key, required this.thucPham}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final viewModel = Provider.of<FoodDetailViewModel>(context);
    double fontSize = 16.0;
    return WillPopScope(
      onWillPop: () async {
        NavigationHelper.pushReplacement(
            context: context, page: const ManageAllFoodView());
        return true;
      },
      child: Scaffold(
        appBar: buildAppBar(size, context, viewModel),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: ListView(
                children: [
                  Card(
                    elevation: 10.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: constraints.maxWidth,
                        child: CarouselSlider.builder(
                          itemCount: thucPham.urlHinhAnh!.length,
                          itemBuilder: (context, i, id) {
                            return GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Image.network(
                                    thucPham.urlHinhAnh![i],
                                    width: constraints.maxWidth,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            height: 300,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            reverse: false,
                            aspectRatio: 5.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          thucPham.ten.toString(),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: constraints.maxWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mô tả',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${thucPham.moTa}',
                              textAlign: TextAlign.justify,
                              overflow: TextOverflow.fade,
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: constraints.maxWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Chi tiết',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${thucPham.chiTiet}',
                              textAlign: TextAlign.justify,
                              overflow: TextOverflow.fade,
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: constraints.maxWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Giá: ',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            NumberFormat('###,###').format(thucPham.giaTien) +
                                'đ',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: constraints.maxWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Danh mục: ',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            thucPham.danhMuc!.loaiDanhMuc!,
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: constraints.maxWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Ngày thêm: ',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            DateFormat('dd/MM/yyy').format(thucPham.createdAt!),
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _showMaterialDialog(
                                context, "Bạn muốn xóa món ăn này!", viewModel);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.redAccent,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Xóa món ăn',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Cập nhật món ăn',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  AppBar buildAppBar(
      Size size, BuildContext context, FoodDetailViewModel viewModel) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      title: Column(
        children: [
          Text(
            'Chi tiết món ăn',
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
        onPressed: () {},
      ),
    );
  }

  _dismissDialog(BuildContext context) {
    Navigator.pop(context);
  }

  void _showMaterialDialog(
      BuildContext context, String text, FoodDetailViewModel viewModel) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Cảnh báo',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            content: Text(text),
            actions: <Widget>[
              TextButton(
                  onPressed: () async {
                    bool kq = await viewModel.xoaThucPham(context, thucPham);
                    if (kq) {
                      _dismissDialog(context);
                      NavigationHelper.push(
                          context: context, page: const ManageAllFoodView());
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Xóa món thành công")));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Xóa không thành công")));
                    }
                  },
                  child: Text('Yes')),
              TextButton(
                  onPressed: () {
                    _dismissDialog(context);
                  },
                  child: Text('No')),
            ],
          );
        });
  }
}
