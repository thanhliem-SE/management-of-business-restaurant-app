import 'package:flutter/material.dart';
import 'package:go_quick_app/components/show_alert_dialog.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/chi_tiet_thuc_pham.dart';
import 'package:go_quick_app/views/select_category/select_category_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ListViewFood extends StatelessWidget {
  final List<ChiTietThucPham> listChiTietThucPham;
  final bool isDialog;
  const ListViewFood(
      {Key? key, required this.listChiTietThucPham, this.isDialog = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final viewModel = Provider.of<SelectCategoryViewModel>(context);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listChiTietThucPham.length,
      padding: EdgeInsets.all(size.width * 0.05),
      itemBuilder: (BuildContext context, int index) {
        ChiTietThucPham item = listChiTietThucPham[index];
        int amount = viewModel.getSoLuongChonMon(item.maChiTietThucPham!);
        return InkWell(
          onLongPress: () {
            showAlertDialog(
                context: context,
                title: item.thucPham!.ten!,
                message: item.thucPham!.moTa!);
          },
          child: Container(
            padding: EdgeInsets.all(size.width * 0.02),
            color: Colors.white,
            child: isDialog
                ? Column(
                    children: [
                      foodView(item: item, size: size),
                      quantityChangeView(
                          amount: amount,
                          size: size,
                          item: item,
                          viewModel: viewModel),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      foodView(item: item, size: size),
                      quantityChangeView(
                          amount: amount,
                          size: size,
                          item: item,
                          viewModel: viewModel),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Row foodView({required ChiTietThucPham item, required Size size}) {
    return Row(
      children: [
        Image.network(
          item.thucPham!.urlHinhAnh![0],
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
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
        SizedBox(width: size.width * 0.01),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width * 0.3,
              child: Text(
                item.thucPham!.ten!,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              NumberFormat('###,###').format(item.thucPham!.giaTien) + 'đ',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.blueGrey),
            ),
          ],
        ),
      ],
    );
  }

  Row quantityChangeView(
      {required int amount,
      required Size size,
      required ChiTietThucPham item,
      required SelectCategoryViewModel viewModel}) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            if (amount > 0) {
              viewModel.setSoLuongChonMon(item.maChiTietThucPham!, amount - 1);
            }
          },
          icon: Icon(Icons.remove_circle_outlined),
          color: (amount > 0) ? kPrimaryColor : Colors.blueGrey,
          iconSize: size.width * 0.07,
        ),
        Text(
          amount.toString(),
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        IconButton(
          onPressed: () {
            if (amount < item.soLuong!) {
              viewModel.setSoLuongChonMon(item.maChiTietThucPham!, amount + 1);
            }
          },
          icon: Icon(Icons.add_circle_outlined),
          color: (amount < item.soLuong!) ? kPrimaryColor : Colors.blueGrey,
          iconSize: size.width * 0.07,
        ),
      ],
    );
  }
}
