import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/thuc_pham.dart';
import 'package:go_quick_app/utils/helper.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/food_detail/food_detail_view_model.dart';
import 'package:go_quick_app/views/home/home_view.dart';
import 'package:go_quick_app/views/manage_food/manage_all_food_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailFoodView extends StatefulWidget {
  final String quyen;
  final ThucPham thucPham;
  const DetailFoodView({Key? key, required this.thucPham, required this.quyen})
      : super(key: key);

  @override
  State<DetailFoodView> createState() => _DetailFoodViewState();
}

class _DetailFoodViewState extends State<DetailFoodView> {
  TextEditingController? _tenController,
      _moTaController,
      _chiTietController,
      _giaController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tenController = TextEditingController();
    _moTaController = TextEditingController();
    _chiTietController = TextEditingController();
    _giaController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final viewModel = Provider.of<FoodDetailViewModel>(context);
    double fontSize = 16.0;
    return WillPopScope(
      onWillPop: () async {
        NavigationHelper.pushReplacement(
            context: context, page: const ManageAllFoodView());
        viewModel.isViewDetail = true;
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
                          itemCount: widget.thucPham.urlHinhAnh!.length,
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
                                    widget.thucPham.urlHinhAnh![i],
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
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
                        viewModel.isViewDetail
                            ? Text(
                                widget.thucPham.ten.toString(),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : TextField(
                                controller: _tenController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: kPrimaryColor),
                                  ),
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
                            child: viewModel.isViewDetail
                                ? Text(
                                    '${widget.thucPham.moTa}',
                                    textAlign: TextAlign.justify,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(fontSize: fontSize),
                                  )
                                : TextField(
                                    controller: _moTaController,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: kPrimaryColor),
                                      ),
                                    ),
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
                            child: viewModel.isViewDetail
                                ? Text(
                                    '${widget.thucPham.chiTiet}',
                                    textAlign: TextAlign.justify,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(fontSize: fontSize),
                                  )
                                : TextField(
                                    controller: _chiTietController,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: kPrimaryColor),
                                      ),
                                    ),
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
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Giá: ',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: viewModel.isViewDetail
                                ? Text(
                                    NumberFormat('###,###')
                                            .format(widget.thucPham.giaTien) +
                                        'đ',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: _giaController,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: kPrimaryColor),
                                        ),
                                      ),
                                    ),
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
                            'Danh mục: ',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.thucPham.danhMuc!.loaiDanhMuc!,
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
                            DateFormat('dd/MM/yyy')
                                .format(widget.thucPham.createdAt!),
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
                            child: ['QUANLY'].contains(widget.quyen)
                                ? Text(
                                    'Xóa món ăn',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Container(),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          onPressed: () async {
                            if (!viewModel.isViewDetail) {
                              widget.thucPham.ten = _tenController?.text;
                              widget.thucPham.moTa = _moTaController?.text;
                              widget.thucPham.chiTiet =
                                  _chiTietController?.text;
                              widget.thucPham.giaTien = _giaController != null
                                  ? double.tryParse("${_giaController?.text}")
                                  : 0;
                              await viewModel.updateThucPham(
                                  context, widget.thucPham);
                            } else {
                              _tenController?.text =
                                  widget.thucPham.ten.toString();
                              _moTaController?.text =
                                  widget.thucPham.moTa.toString();
                              _chiTietController?.text =
                                  widget.thucPham.chiTiet.toString();
                              _giaController?.text =
                                  widget.thucPham.giaTien.toString();
                            }
                            viewModel.setIsViewDetail =
                                !viewModel.getIsViewDetail;
                          },
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
        onPressed: () {
          NavigationHelper.pushReplacement(
              context: context, page: const ManageAllFoodView());
          viewModel.isViewDetail = true;
        },
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
                    bool kq =
                        await viewModel.xoaThucPham(context, widget.thucPham);
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
