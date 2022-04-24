import 'package:flutter/material.dart';
import 'package:go_quick_app/components/app_bar.dart';
import 'package:go_quick_app/models/hoa_don.dart';

class BillView extends StatelessWidget {
  final int maHoaDon;

  const BillView({Key? key, required this.maHoaDon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          context: context, title: 'Hóa đơn #' + maHoaDon.toString()),
      body: Column(
        children: [],
      ),
    );
  }
}
