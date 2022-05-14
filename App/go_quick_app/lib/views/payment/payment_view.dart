import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/chi_tiet_hoa_don.dart';
import 'package:go_quick_app/models/hoa_don.dart';
import 'package:go_quick_app/utils/navigation_helper.dart';
import 'package:go_quick_app/views/bill/bill_view.dart';
import 'package:go_quick_app/views/payment/payment_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({
    Key? key,
    required this.hoaDon,
  }) : super(key: key);

  final HoaDon hoaDon;

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  bool isView = true;
  late TextEditingController _tienKhachTraController;
  @override
  void initState() {
    super.initState();
    _tienKhachTraController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final viewModel = Provider.of<PayMentViewModel>(context);
    List<String> listTien = [
      '10000',
      '20000',
      '50000',
      '100000',
      '200000',
      '500000'
    ];

    if (viewModel.getIsInit == true) {
      return WillPopScope(
        onWillPop: () async {
          NavigationHelper.pushReplacement(
              context: context,
              page: BillView(
                hoaDon: viewModel.hoaDon,
              ));
          viewModel.clear();
          return true;
        },
        child: Scaffold(
          appBar: buildAppBar(size, context, widget.hoaDon, viewModel),
          body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SizedBox(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  child: viewModel.choThanhToan
                      ? SuccessThanhToan(constraints, context, viewModel)
                      : MainThanhToan(constraints, context, viewModel));
            },
          ),
        ),
      );
    } else {
      viewModel.initialize(widget.hoaDon, context);
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

  AppBar buildAppBar(Size size, BuildContext context, HoaDon hoaDon,
      PayMentViewModel viewModel) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      actions: [
        IconButton(
          onPressed: () {
            isView = !isView;
            setState(() {});
            try {
              if (_tienKhachTraController.text.isNotEmpty) {
                viewModel.nhapTienKhacTra(
                    double.parse(_tienKhachTraController.text));
              }
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("error: ${e.toString()}")));
            }
          },
          icon: isView
              ? Icon(Icons.edit_off_outlined)
              : Icon(Icons.edit_outlined),
        ),
      ],
      title: Column(
        children: [
          Text(
            'Thanh toán hóa đơn số ${hoaDon.maHoaDon} bàn ${hoaDon.ban?.soBan}',
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
          NavigationHelper.pushReplacement(
              context: context,
              page: BillView(
                hoaDon: viewModel.hoaDon,
              ));
          viewModel.clear();
        },
      ),
    );
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

  ListView MainThanhToan(BoxConstraints constraints, BuildContext context,
      PayMentViewModel viewModel) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: constraints.maxWidth,
                child: Text(
                  "Chi tiết hóa đơn #${widget.hoaDon.maHoaDon}",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: constraints.maxWidth,
                child: widget.hoaDon.chiTietHoaDons != null
                    ? buildListOrder(
                        context: context, list: widget.hoaDon.chiTietHoaDons!)
                    : Container(),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Tổng tiền: "),
                    Text(
                        NumberFormat('###,###')
                                .format(viewModel.tinTongTienHoaDon()) +
                            'đ',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ],
                ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tiền khách trả: "),
                  isView
                      ? Text(
                          NumberFormat('###,###')
                                  .format(viewModel.thanhToan.getTienKhachTra) +
                              'đ',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      : SizedBox(
                          width: constraints.maxWidth * 0.2,
                          child: TextField(
                            controller: _tienKhachTraController,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: kPrimaryColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kPrimaryColor),
                              ),
                            ),
                            cursorColor: kPrimaryColor,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tiền thừa: "),
                  Text(
                      NumberFormat('###,###')
                              .format(viewModel.thanhToan.getTienThua ?? 0) +
                          'đ',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20)),
                ],
              ),
            ),
          ),
        ),
        viewModel.daThanhToan
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: ElevatedButton(
                    onPressed: () {
                      viewModel.xacNhanThanhToan(context);
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.payment),
                          SizedBox(
                            width: constraints.maxHeight * 0.025,
                          ),
                          Text(
                            'Đã thanh toán',
                            style: TextStyle(fontSize: 18.0),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  ListView SuccessThanhToan(BoxConstraints constraints, BuildContext context,
      PayMentViewModel viewModel) {
    return ListView(
      children: [
        Center(
          child: Column(
            children: [
              Icon(
                Icons.payment_outlined,
                size: constraints.maxWidth * 0.3,
                color: kPrimaryColor,
              ),
              Text(
                'Đang chờ xuất hóa đơn',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: constraints.maxWidth,
                child: Text(
                  "Chi tiết hóa đơn",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: constraints.maxWidth,
                child: widget.hoaDon.chiTietHoaDons != null
                    ? buildListOrder(
                        context: context, list: widget.hoaDon.chiTietHoaDons!)
                    : Container(),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Tổng tiền: "),
                    Text(
                        NumberFormat('###,###')
                                .format(viewModel.tinTongTienHoaDon()) +
                            'đ',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ],
                ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tiền khách trả: "),
                  Text(
                    NumberFormat('###,###').format(
                            viewModel.hoaDon.thanhToan?.getTienKhachTra) +
                        'đ',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tiền thừa: "),
                  Text(
                      NumberFormat('###,###').format(
                              viewModel.hoaDon.thanhToan?.tienThua ?? 0) +
                          'đ',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
