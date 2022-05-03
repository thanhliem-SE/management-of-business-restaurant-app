import 'package:flutter/material.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/chi_tiet_thuc_pham.dart';
import 'package:intl/intl.dart';

class ListViewFood extends StatelessWidget {
  final List<ChiTietThucPham> listChiTietThucPham;
  final bool isDialog;
  const ListViewFood(
      {Key? key, required this.listChiTietThucPham, this.isDialog = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listChiTietThucPham.length,
      padding: EdgeInsets.all(size.width * 0.05),
      itemBuilder: (BuildContext context, int index) {
        ChiTietThucPham item = listChiTietThucPham[index];
        // int amount = _viewModel.getAmoutFoodOrder(index);
        int amount = 1;
        return Container(
          padding: EdgeInsets.all(size.width * 0.02),
          color: Colors.white,
          // width: size.width * 1,
          // height: size.height * 0.2,
          child: isDialog
              ? Column(
                  children: [
                    foodView(item: item, size: size),
                    quantityChangeView(amount: amount, size: size, item: item),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    foodView(item: item, size: size),
                    quantityChangeView(amount: amount, size: size, item: item),
                  ],
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
          fit: BoxFit.cover,
          height: size.height * 0.1,
          width: size.width * 0.2,
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
      required ChiTietThucPham item}) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            // if (amount > 0) {
            //   _viewModel.setAmoutFoodOrder(
            //       index, amount - 1);
            // }
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
            // if (amount < item.soLuong) {
            //   _viewModel.setAmoutFoodOrder(
            //       index, amount + 1);
            // }
          },
          icon: Icon(Icons.add_circle_outlined),
          color: (amount < item.soLuong!) ? kPrimaryColor : Colors.blueGrey,
          iconSize: size.width * 0.07,
        ),
      ],
    );
  }
}
