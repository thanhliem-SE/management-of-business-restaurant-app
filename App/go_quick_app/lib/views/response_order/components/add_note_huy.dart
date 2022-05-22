import 'package:flutter/material.dart';
import 'package:go_quick_app/components/rounded_button.dart';
import 'package:go_quick_app/components/rounded_input_field.dart';
import 'package:go_quick_app/components/show_alert_dialog.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/chi_tiet_hoa_don.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/views/response_order/response_order_view_model.dart';
import 'package:provider/provider.dart';

class AddNoteCancelDialog extends StatelessWidget {
  final HoaDon hoaDon;
  const AddNoteCancelDialog({Key? key, required this.hoaDon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final viewModel = Provider.of<ResponseOrderViewModel>(context);
    List<ChiTietHoaDon> listChiTietHoaDon =
        viewModel.getListChiTietHonDonByMaHoaDon(hoaDon.maHoaDon!);
    listChiTietHoaDon = listChiTietHoaDon
        .where((element) =>
            element.daCheBien == false && element.isDeleted == false)
        .toList();
    return AlertDialog(
      title: const Text(
        'Không Tiếp Nhận Món Ăn',
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Container(
          width: size.width,
          child: Column(
            children: [
              ListView.builder(
                itemCount: listChiTietHoaDon.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  ChiTietHoaDon item = listChiTietHoaDon[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          fit: BoxFit.fill,
                          width: size.width * 0.2,
                          height: size.height * 0.1,
                        ),
                        SizedBox(
                          width: size.width * 0.3,
                          child: Text(
                            item.thucPham!.ten!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),
                        item.khongTiepNhan == false
                            ? IconButton(
                                onPressed: () {
                                  viewModel.setKhongTiepNhanForChiTietHoaDon(
                                      hoaDon.maHoaDon!, item.maChiTietHoaDon!);
                                },
                                icon: const Icon(Icons.check_box_outline_blank))
                            : IconButton(
                                onPressed: () {
                                  viewModel.setKhongTiepNhanForChiTietHoaDon(
                                      hoaDon.maHoaDon!, item.maChiTietHoaDon!);
                                },
                                icon: const Icon(Icons.check_box_outlined)),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              TextField(
                maxLines: 4,
                onChanged: (value) {
                  viewModel.setGhiChu(value);
                },
                decoration: const InputDecoration(
                    hintText: 'Lý do hủy', fillColor: kPrimaryLightColor),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              RoundedButton(
                  text: 'HỦY',
                  press: () {
                    if (viewModel.getGhiChu() == '') {
                      showAlertDialog(
                          context: context,
                          title: 'Thất bại',
                          message: 'Vui lòng nhập lý do hủy yêu cầu đặt món');
                    } else {
                      hoaDon.ghiChu = viewModel.getGhiChu();
                      viewModel.setGhiChu('');
                      viewModel
                          .updateKhongTiepNhanChiTietHoaDon(listChiTietHoaDon);
                      viewModel.updateTrangThaiHoaDon(hoaDon, 'KHONGTIEPNHAN');
                      Navigator.pop(context);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
