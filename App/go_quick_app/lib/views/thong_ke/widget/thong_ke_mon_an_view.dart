import 'package:flutter/material.dart';
import 'package:go_quick_app/components/app_bar.dart';
import 'package:go_quick_app/models/thuc_pham.dart';
import 'package:go_quick_app/views/thong_ke/widget/thong_ke_mon_an_view_model.dart';
import 'package:provider/provider.dart';

class ThongKeMonAnView extends StatefulWidget {
  const ThongKeMonAnView({Key? key}) : super(key: key);

  @override
  State<ThongKeMonAnView> createState() => _ThongKeMonAnViewState();
}

class _ThongKeMonAnViewState extends State<ThongKeMonAnView> {
  List<int> month = [for (var i = 1; i <= 12; i += 1) i];
  List<int> years = [for (var i = 2022; i <= 2100; i += 1) i];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final viewModel = Provider.of<ThongKeMonAnViewModel>(context);

    if (viewModel.isInit == false) {
      viewModel.init();
    }

    return Scaffold(
      appBar:
          buildAppBar(context: context, title: 'Thống kê món ăn theo tháng'),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.only(top: 5.0),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      labelText: "Tháng",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        onChanged: (int? value) {
                          viewModel.monthPicked = value ?? 1;
                          viewModel.init();
                        },
                        value: viewModel.monthPicked,
                        items: month.map((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      labelText: "Năm",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        onChanged: (int? value) {
                          viewModel.yearPicked = value ?? 2022;
                          viewModel.init();
                        },
                        value: viewModel.yearPicked,
                        items: years.map((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          viewModel.listThongKeMonAn.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.listThongKeMonAn.length,
                    itemBuilder: (context, index) {
                      ThucPham thucPham = viewModel.getThucPhamByMaThucPham(
                          viewModel.listThongKeMonAn[index].maThucPham ?? 1);
                      int tongSoLuong = viewModel.getTongSoLuongByMaThucPham(
                          viewModel.listThongKeMonAn[index].maThucPham ?? 1);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.network(
                              thucPham.urlHinhAnh![0],
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                              fit: BoxFit.cover,
                              height: size.height * 0.1,
                              width: size.width * 0.2,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.error_outline);
                              },
                            ),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            Container(
                              width: size.width * 0.5,
                              child: Text(
                                thucPham.ten ?? 'Thực phẩm',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            Container(
                              width: size.width * 0.2,
                              child: Text(
                                'SL: ${tongSoLuong.toString()}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              : Container(
                  child: const Center(
                    child: Text('Không có hóa đơn trong tháng này'),
                  ),
                ),
        ],
      ),
    );
  }
}
