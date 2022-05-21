import 'package:flutter/material.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/views/thong_ke/thong_ke_view_model.dart';
import 'package:provider/provider.dart';

class ThongKeView extends StatefulWidget {
  ThongKeView({Key? key}) : super(key: key);

  @override
  State<ThongKeView> createState() => _ThongKeViewState();
}

class _ThongKeViewState extends State<ThongKeView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final viewModel = Provider.of<ThongKeViewModel>(context);
    if (viewModel.isInitialized) {
      return Scaffold(
        appBar: buildAppBar(size, context, viewModel),
        body: ListView.builder(
          itemCount: viewModel.hoadons.length,
          itemBuilder: (context, index) {
            HoaDon hoaDon = viewModel.hoadons[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Mã hóa đơn: ${hoaDon.maHoaDon}"),
            );
          },
        ),
      );
    } else {
      viewModel.Init(context);
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
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
