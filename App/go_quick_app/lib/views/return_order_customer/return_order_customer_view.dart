import 'package:flutter/material.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/socket_view_model.dart';
import 'package:go_quick_app/views/return_order_customer/return_order_customer_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReturnOrderCustomerview extends StatelessWidget {
  const ReturnOrderCustomerview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final viewModel = Provider.of<ReturnOrderCustomerViewModel>(context);
    if (viewModel.getInitialized) {
      return WillPopScope(
        onWillPop: () async {
          viewModel.clear();
          Navigator.pop(context);
          return true;
        },
        child: Scaffold(
          appBar: buildAppBar(size, context, viewModel),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return ListView.builder(
                itemCount: viewModel.listHoaDon.length,
                itemBuilder: (context, index) {
                  HoaDon hoaDon = viewModel.listHoaDon[index];
                  return Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hóa đơn số ${hoaDon.maHoaDon}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Số bàn: ${hoaDon.ban?.maSoBan}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Giờ tạo: ${DateFormat('dd/MM/yyyy HH:mm:ss').format(hoaDon.createdAt!)}',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Giờ xuất hóa đơn: ${DateFormat('dd/MM/yyyy HH:mm:ss').format(hoaDon.updatedAt!)}',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Người lập hóa đơn: ${hoaDon.nguoiLapHoaDon?.tenNhanVien}',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                await viewModel.updateHoaDon(context, hoaDon);
                              },
                              child: SizedBox(
                                width: constraints.maxWidth,
                                child: const Text(
                                  'Nhận trả hóa đơn',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      );
    } else {
      viewModel.intitializedAsync(context);
      Provider.of<SocketViewModel>(context)
          .setReturnOrderCustomerViewModel(viewModel, context);
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

  AppBar buildAppBar(
      Size size, BuildContext context, ReturnOrderCustomerViewModel viewModel) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      title: Column(
        children: [
          const Text(
            'Danh sách trả hóa đơn',
            style: const TextStyle(color: Colors.white, fontSize: 16),
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
          Navigator.pop(context);
        },
      ),
    );
  }
}
