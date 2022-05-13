import 'package:flutter/material.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/views/manage_payment/manage_payment_view_model.dart';
import 'package:provider/provider.dart';

class ManagePaymentView extends StatelessWidget {
  const ManagePaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final viewModel = Provider.of<ManagePayMentViewModel>(context);
    if (viewModel.isInitialized) {
      return Scaffold(
        appBar: buildAppBar(size, context),
        body: ListView.builder(
          itemCount: viewModel.listHoaDon.length,
          itemBuilder: (context, index) {
            HoaDon hoaDon = viewModel.getListHoaDon[index];
            return Text("mã hóa đơn: ${hoaDon.maHoaDon}");
          },
        ),
      );
    } else {
      viewModel.initialAsync(context);
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: kPrimaryColor,
            strokeWidth: 2.0,
          ),
        ),
      );
    }
  }

  AppBar buildAppBar(Size size, BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      title: Column(
        children: [
          Text(
            'Quản lý thanh toán',
            style: TextStyle(color: Colors.white, fontSize: 16),
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
          Navigator.pop(context);
        },
      ),
    );
  }
}
