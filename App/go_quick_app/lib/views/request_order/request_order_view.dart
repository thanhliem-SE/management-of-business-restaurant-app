import 'package:flutter/material.dart';
import 'package:go_quick_app/components/rounded_button.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/request_order/request_order_view_model.dart';
import 'package:go_quick_app/views/select_category/select_category_view.dart';
import 'package:provider/provider.dart';

class RequestOrderView extends StatelessWidget {
  const RequestOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RequestOrderViewModel>(context);

    if (viewModel.isInit == false) {
      viewModel.init();
    }

    Size size = MediaQuery.of(context).size;
    List<HoaDon> listHoaDonChuaThanhToan = viewModel.getListHoaDon();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: size.height * 0.05,
          ),
        ),
        title: const Text(
          'Yêu cầu đặt món',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context, builder: (context) => SelectTableCount());
            },
            icon: Icon(
              Icons.add,
              color: Colors.black,
              size: size.height * 0.05,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.refresh_sharp,
              color: Colors.black,
              size: size.height * 0.04,
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.grid_view_sharp,
                      size: size.width * 0.12,
                      color: Colors.blueGrey,
                    ),
                  ),
                  Image.asset(
                    'assets/icons/icon_table.png',
                    color: Colors.deepPurpleAccent,
                    width: size.width * 0.2,
                    height: size.height * 0.12,
                    fit: BoxFit.fill,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.table_rows_sharp,
                      size: size.width * 0.12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Text('Danh Sách Bàn Ăn Đang Phục Vụ',
                style: TextStyle(
                    fontSize: size.height * 0.03,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            Expanded(
              child: listHoaDonChuaThanhToan.length > 0
                  ? GridView.builder(
                      primary: false,
                      padding: const EdgeInsets.all(20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: listHoaDonChuaThanhToan.length,
                      itemBuilder: (BuildContext context, int index) {
                        HoaDon item = listHoaDonChuaThanhToan[index];
                        return cardTableOrder(
                            size: size,
                            people: item.soNguoi,
                            numTable: item.ban,
                            context: context);
                      },
                    )
                  : const Text(
                      'Không có bàn ăn nào đang phục vụ',
                      style: TextStyle(fontSize: 18),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Container cardTableOrder(
      {required Size size,
      required int people,
      required int numTable,
      required BuildContext context}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.blueGrey,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () {
          NavigationHelper.push(
              context: context,
              page:
                  SelectCategoryView(numTable: numTable, numCustomer: people));
        },
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.people_alt_outlined,
                  color: Colors.deepPurpleAccent,
                  size: size.width * 0.12,
                ),
                Text(
                  numTable.toString(),
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.005),
            Row(
              children: [
                Text(
                  '$people Người',
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SelectTableCount extends StatelessWidget {
  SelectTableCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RequestOrderViewModel>(context);
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      title: const Text(
        'CHỌN BÀN',
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      color: Colors.red,
                      width: 14,
                      height: 14,
                    ),
                    const Text(
                      ' : Full chỗ',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Image.asset(
                  'assets/icons/icon_table.png',
                ),
                Row(
                  children: [
                    Container(
                      color: kPrimaryLightColor,
                      width: 14,
                      height: 14,
                    ),
                    const Text(
                      ' : Bàn Rỗng',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
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
                  var color = viewModel.getNumTable() == index
                      ? kPrimaryColor
                      : kPrimaryLightColor;
                  return InkWell(
                    onTap: () {
                      if (!viewModel.getListTableDangPhucVu().contains(index)) {
                        viewModel.setNumTable(index);
                      }
                    },
                    child: Card(
                      color: viewModel.getListTableDangPhucVu().contains(index)
                          ? Colors.red
                          : color,
                      child: Center(
                          child: Text(
                        (index + 1).toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: viewModel.getNumTable() == index ||
                                    viewModel
                                        .getListTableDangPhucVu()
                                        .contains(index)
                                ? Colors.white
                                : Colors.black),
                      )),
                    ),
                  );
                },
              ),
            ),
            RoundedButton(
              text: 'TIẾP THEO',
              press: () {
                showDialog(
                    context: context,
                    builder: (context) => SelectCustomerCount());
              },
              color: kPrimaryColor,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class SelectCustomerCount extends StatelessWidget {
  const SelectCustomerCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RequestOrderViewModel>(context);
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      title: const Text(
        'CHỌN SỐ KHÁCH',
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Icon(
              Icons.people,
              size: size.height * 0.08,
            ),
            SizedBox(
              height: size.height * 0.01,
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
                  var color = viewModel.getNumCustomer() == index
                      ? kPrimaryColor
                      : kPrimaryLightColor;
                  return InkWell(
                    onTap: () {
                      viewModel.setNumCustomer(index);
                    },
                    child: Card(
                      color: color,
                      child: Center(
                          child: Text(
                        (index + 1).toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: viewModel.getNumCustomer() == index
                                ? Colors.white
                                : Colors.black),
                      )),
                    ),
                  );
                },
              ),
            ),
            RoundedButton(
              text: 'TIẾP THEO',
              press: () {
                NavigationHelper.push(
                    context: context,
                    page: SelectCategoryView(
                        numTable: viewModel.getNumTable() + 1,
                        numCustomer: viewModel.getNumCustomer() + 1));
              },
              color: kPrimaryColor,
              textColor: Colors.white,
            ),
            RoundedButton(
              text: 'QUAY LẠI',
              press: () {
                Navigator.pop(context);
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
