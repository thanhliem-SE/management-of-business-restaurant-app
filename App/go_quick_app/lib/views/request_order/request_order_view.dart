import 'package:flutter/material.dart';
import 'package:go_quick_app/components/rounded_button.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/request_order/request_order_view_model.dart';
import 'package:go_quick_app/views/select_category/select_category_view.dart';
import 'package:provider/provider.dart';

class RequestOrderView extends StatelessWidget {
  const RequestOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: size.height * 0.05,
          ),
        ),
        title: Text('Yêu cầu đặt món'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => const SelectTableCount());
            },
            icon: Icon(
              Icons.add,
              size: size.height * 0.05,
            ),
          ),
        ],
      ),
      body: Container(
        color: kPrimaryLightColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.grid_view_sharp,
                      size: size.width * 0.12,
                      color: Colors.black,
                    ),
                  ),
                  Image.asset(
                    'assets/icons/icon_table.png',
                    color: Colors.black,
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
            Expanded(
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                children: <Widget>[
                  cardTableOrder(
                      size: size, people: 2, numTable: '01', context: context),
                  cardTableOrder(
                      size: size, people: 2, numTable: '02', context: context),
                  cardTableOrder(
                      size: size, people: 2, numTable: '06', context: context),
                  cardTableOrder(
                      size: size, people: 2, numTable: '07', context: context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container cardTableOrder(
      {required Size size,
      required int people,
      required String numTable,
      required BuildContext context}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: InkWell(
          onTap: () {
            // NavigationHelper.push(
            //     context: context,
            //     page: SelectCategoryView(
            //       numTable: numTable,
            //       numCustomer: people,
            //     ));
          },
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.people,
                    size: size.width * 0.1,
                  ),
                  SizedBox(
                    width: size.width * 0.08,
                  ),
                  Text(
                    numTable,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                '$people People',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          )),
    );
  }
}

class SelectTableCount extends StatelessWidget {
  const SelectTableCount({Key? key}) : super(key: key);

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
            Image.asset(
              'assets/icons/icon_table.png',
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
                      viewModel.setNumTable(index);
                    },
                    child: Card(
                      color: color,
                      child: Center(
                          child: Text(
                        (index + 1).toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: viewModel.getNumTable() == index
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
