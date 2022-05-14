import 'package:flutter/material.dart';
import 'package:go_quick_app/components/app_bar.dart';
import 'package:go_quick_app/components/rounded_button.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/chi_tiet_hoa_don.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/utils/helper.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/bill/bill_view_model.dart';
import 'package:go_quick_app/views/payment/payment_view.dart';
import 'package:go_quick_app/views/payment/payment_view_model.dart';
import 'package:go_quick_app/views/select_category/select_category_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BillView extends StatelessWidget {
  final HoaDon hoaDon;

  const BillView({Key? key, required this.hoaDon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BillViewModel>(context);

    if (viewModel.getIsInit() == false) {
      viewModel.init(hoaDon.maHoaDon!);
    }

    final listChiTietHoaDon = viewModel.getListChiTietHoaDon();

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(
          context: context,
          title: 'Hóa đơn #' + hoaDon.maHoaDon.toString(),
          viewModel: viewModel,
          actions: [
            IconButton(
              onPressed: () {
                NavigationHelper.pushReplacement(
                    context: context,
                    page: SelectCategoryView(
                      hoaDon: hoaDon,
                      listChiTietHoaDon: listChiTietHoaDon,
                    ));
                viewModel.clear();
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                NavigationHelper.pushReplacement(
                    context: context,
                    page: SelectCategoryView(
                      hoaDon: hoaDon,
                    ));
                viewModel.clear();
              },
              icon: const Icon(Icons.add),
            ),
            IconButton(
                onPressed: () {
                  viewModel.init(hoaDon.maHoaDon!);
                },
                icon: const Icon(Icons.refresh))
          ]),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: size.width,
                margin: const EdgeInsets.only(top: 10),
                child: buildTextSpan(
                    boldText: 'Trạng thái: ',
                    normalText: Helper.getTrangThaiHoaDon(hoaDon.tinhTrang!)),
              ),
              Container(
                width: size.width,
                margin: const EdgeInsets.only(top: 10),
                child: buildTextSpan(
                    boldText: 'Thời gian: ',
                    normalText: DateFormat('dd/MM/yyyy HH:mm')
                        .format(hoaDon.createdAt!)),
              ),
              Container(
                width: size.width,
                margin: const EdgeInsets.only(top: 10),
                child: buildTextSpan(
                    boldText: 'Người lập hóa đơn: ',
                    normalText: hoaDon.nguoiLapHoaDon!.tenNhanVien!),
              ),
              Container(
                width: size.width,
                margin: const EdgeInsets.only(top: 10),
                child: buildTextSpan(
                    boldText: 'Ghi chú: ',
                    normalText: hoaDon.ghiChu == null || hoaDon.ghiChu!.isEmpty
                        ? 'Không có'
                        : hoaDon.ghiChu!),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                padding: const EdgeInsets.all(5.0),
                width: size.width,
                color: Colors.blueGrey[50],
                child: Text(
                  'Danh Sách Đặt Món - Bàn ' + hoaDon.ban!.viTri.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              listChiTietHoaDon.length > 0
                  ? buildListOrder(context: context, list: listChiTietHoaDon)
                  : Container(),
              SizedBox(height: size.height * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Tổng tiền',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text(
                      NumberFormat('###,###')
                              .format(viewModel.getTotalPrice()) +
                          'đ',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20)),
                ],
              ),
              SizedBox(height: size.height * 0.04),
              Flexible(
                fit: FlexFit.loose,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          NavigationHelper.push(
                            context: context,
                            page: PaymentView(
                              hoaDon: hoaDon,
                            ),
                          );
                        },
                        child: Container(
                          color: kPrimaryColor,
                          width: size.width * 0.9,
                          height: size.height * 0.05,
                          alignment: Alignment.center,
                          child: const Text(
                            'Thanh Toán',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      viewModel.kiemTraKhongTiepNhan()
                          ? InkWell(
                              onTap: () async {
                                await viewModel.updateHoaDon(context, hoaDon);
                              },
                              child: Container(
                                color: Colors.redAccent[700],
                                width: size.width * 0.9,
                                height: size.height * 0.05,
                                alignment: Alignment.center,
                                child: const Text(
                                  'Hủy',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildTextSpan({required String boldText, required String normalText}) {
    return RichText(
        text: TextSpan(
      text: boldText,
      style: const TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
      children: <TextSpan>[
        TextSpan(
            text: normalText,
            style: const TextStyle(fontWeight: FontWeight.normal)),
      ],
    ));
  }

  buildListOrder(
      {required BuildContext context, required List<ChiTietHoaDon> list}) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        ChiTietHoaDon item = list[index];
        return Container(
          padding: const EdgeInsets.only(bottom: 10),
          margin: const EdgeInsets.only(top: 10),
          color: item.khongTiepNhan == false ? Colors.white : Colors.red[100],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                item.thucPham!.urlHinhAnh![0],
                width: size.width * 0.2,
                height: size.height * 0.1,
                fit: BoxFit.fill,
              ),
              Column(
                children: [
                  SizedBox(
                    width: size.width * 0.3,
                    child: Text(
                      item.thucPham!.ten!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  SizedBox(
                    width: size.width * 0.3,
                    child: Text(
                      NumberFormat('###,###').format(item.thucPham!.giaTien!) +
                          'đ',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.blueGrey),
                    ),
                  ),
                ],
              ),
              Text(
                'x' + item.soLuong.toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(width: size.width * 0.1),
              Text(
                NumberFormat('###,###').format(item.thucPham!.giaTien) + 'đ',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        );
      },
    );
  }
}
