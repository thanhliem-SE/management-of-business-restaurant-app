import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/home/home_view.dart';
import 'package:go_quick_app/views/thong_ke/thong_ke_view_model.dart';
import 'package:go_quick_app/views/thong_ke/widget/thong_ke_mon_an_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ThongKeView extends StatefulWidget {
  ThongKeView({Key? key}) : super(key: key);

  @override
  State<ThongKeView> createState() => _ThongKeViewState();
}

class _ThongKeViewState extends State<ThongKeView> {
  int yearPicked = DateTime.now().year;
  int monthPicked = DateTime.now().month;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final viewModel = Provider.of<ThongKeViewModel>(context);
    if (viewModel.isInitialized) {
      return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: RefreshIndicator(
          color: kPrimaryColor,
          onRefresh: () async {
            await viewModel.Init(context);
          },
          child: Scaffold(
            appBar: buildAppBar(size, context, viewModel),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
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
                                      monthPicked = value ?? 1;
                                      setState(() {});
                                    },
                                    value: monthPicked,
                                    items: viewModel.month.map((int value) {
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
                                      yearPicked = value ?? 2022;
                                      setState(() {});
                                    },
                                    value: yearPicked,
                                    items: viewModel.years.map((int value) {
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.grey),
                              onPressed: () async {
                                viewModel.isInitialized = false;
                                monthPicked = DateTime.now().month;
                                yearPicked = DateTime.now().year;
                                setState(() {});
                                await viewModel.loadFilter(
                                    monthPicked, yearPicked, context);
                              },
                              child: Text("Hủy"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: kPrimaryColor),
                              onPressed: () async {
                                viewModel.isInitialized = false;
                                setState(() {});
                                await viewModel.loadFilter(
                                    monthPicked, yearPicked, context);
                              },
                              child: Text("Áp dụng"),
                            ),
                          ),
                        ],
                      ),
                      viewModel.hoadons.isNotEmpty
                          ? Table(
                              border: TableBorder.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                              children: [
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(child: Text('Mã hóa đơn')),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(child: Text('Ngày tạo')),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(child: Text('Doanh thu')),
                                    ),
                                  ],
                                ),
                                for (var hoaDon in viewModel.hoadons)
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                            child: Text('${hoaDon.maHoaDon}')),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                            child: Text(DateFormat('dd/MM/yyyy')
                                                .format(hoaDon.createdAt!))),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            NumberFormat('###,###').format(
                                                    hoaDon.tongThanhTien) +
                                                'đ',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                          child: Text(
                                              'Tổng cộng: ${viewModel.hoadons.length}')),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(child: Text("")),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          NumberFormat('###,###').format(
                                                  viewModel.tinhTongTien(
                                                      viewModel.hoadons)) +
                                              'đ',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Center(
                              child: Text(
                                'Không có hóa đơn trong tháng này',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 18.0),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      viewModel.Init(context);
      viewModel.loadFilter(monthPicked, yearPicked, context);
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: kPrimaryColor,
            strokeWidth: 2.0,
          ),
        ),
      );
    }
  }

  // double getMaxPrice(ThongKeViewModel viewModel) {
  //   double max = 0;
  //   viewModel.hoadons
  //       .sort((a, b) => a.tongThanhTien!.compareTo(b.tongThanhTien!));
  //   max = viewModel.hoadons[0].tongThanhTien!;
  //   return max;
  // }

  AppBar buildAppBar(
      Size size, BuildContext context, ThongKeViewModel viewModel) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      title: Column(
        children: [
          const Text(
            'Thống kê hóa đơn theo tháng',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          viewModel.clear();
          NavigationHelper.pushReplacement(
              context: context, page: const HomeView());
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.arrow_forward_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            NavigationHelper.push(
                context: context, page: const ThongKeMonAnView());
          },
        ),
      ],
    );
  }
}
