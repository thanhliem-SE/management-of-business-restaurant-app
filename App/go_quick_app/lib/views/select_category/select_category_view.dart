import 'package:flutter/material.dart';
import 'package:go_quick_app/components/app_bar.dart';
import 'package:go_quick_app/components/custom_box_shadow.dart';
import 'package:go_quick_app/components/show_alert_diablog.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/chi_tiet_thuc_pham.dart';
import 'package:go_quick_app/models/thuc_pham.dart';
import 'package:go_quick_app/views/request_order/request_order_view_model.dart';
import 'package:go_quick_app/views/select_category/components/list_view_food.dart';
import 'package:go_quick_app/views/select_category/components/search_food_dialog.dart';
import 'package:go_quick_app/views/select_category/select_category_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SelectCategoryView extends StatelessWidget {
  const SelectCategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final requestOrderModel =
        Provider.of<RequestOrderViewModel>(context, listen: false);
    final viewModel = Provider.of<SelectCategoryViewModel>(context);

    Size size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: buildAppBar(size, context),
        body: Column(
          children: [
            SizedBox(
              height: size.height * 0.7,
              child: TabBarView(
                children: [
                  getFoodTab(),
                  getDrinkTab(),
                  getSnackTab(),
                  getOtherTab()
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Container(
                      color: Colors.white,
                      width: size.width * 0.5,
                      height: size.height * 0.05,
                      alignment: Alignment.center,
                      child: Text(
                        'Tổng tiền: ' +
                            NumberFormat('###,###')
                                .format(viewModel.getTotalPrice()) +
                            ' đ',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // showConfirmDialog(context, () {
                        //   _viewModel.navigateToHoaDon(
                        //       soNguoi: numCustomer,
                        //       ban: numTable,
                        //       context: context);
                        // }, 'Bạn có xác nhận đặt món');
                      },
                      child: Container(
                        color: kPrimaryColor,
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        alignment: Alignment.center,
                        child: const Text(
                          'Xác Nhận',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(Size size, BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      bottom: const TabBar(
        tabs: [
          Tab(
            text: 'Thức ăn',
            icon: Icon(Icons.fastfood),
          ),
          Tab(
            text: 'Thức uống',
            icon: Icon(Icons.local_cafe),
          ),
          Tab(
            text: 'Tráng miệng',
            icon: Icon(Icons.cake_outlined),
          ),
          Tab(
            text: 'Khác',
            icon: Icon(Icons.other_houses_outlined),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => (SearchFoodDialog()),
            );
          },
          icon: const Icon(Icons.search),
        )
      ],
      title: const Text(
        'Danh Sách Món',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: size.height * 0.05,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  getFoodTab() {
    List<ChiTietThucPham> listChiTietThucPham = [
      ChiTietThucPham(
          maChiTietThucPham: 1,
          thucPham: ThucPham(
              maThucPham: 1,
              ten: 'Cơm tấm',
              giaTien: 30000,
              urlHinhAnh: [
                'https://statics.vinpearl.com/com-tam-ngon-o-sai-gon-0_1630562640.jpg'
              ]),
          soLuong: 5),
    ];
    return ListViewFood(
      listChiTietThucPham: listChiTietThucPham,
    );
  }

  getSnackTab() {
    List<ChiTietThucPham> listChiTietThucPham = [
      ChiTietThucPham(
          maChiTietThucPham: 1,
          thucPham: ThucPham(
              maThucPham: 2,
              ten: 'Kem ly',
              giaTien: 20000,
              urlHinhAnh: [
                'https://cf.shopee.vn/file/893443060f2c6b9fbfab897c0cd59b08'
              ]),
          soLuong: 5),
    ];
    return ListViewFood(
      listChiTietThucPham: listChiTietThucPham,
    );
  }

  getDrinkTab() {
    List<ChiTietThucPham> listChiTietThucPham = [
      ChiTietThucPham(
          maChiTietThucPham: 1,
          thucPham: ThucPham(
              maThucPham: 3,
              ten: 'Lon CocaCola',
              giaTien: 20000,
              urlHinhAnh: [
                'https://filebroker-cdn.lazada.vn/kf/S7f8ed4d038d743d4852ab22504a211f8K.jpg'
              ]),
          soLuong: 5),
    ];
    return ListViewFood(
      listChiTietThucPham: listChiTietThucPham,
    );
  }

  getOtherTab() {
    List<ChiTietThucPham> listChiTietThucPham = [
      ChiTietThucPham(
          maChiTietThucPham: 4,
          thucPham: ThucPham(
              maThucPham: 4,
              ten: 'Thuốc bắc hầm gà',
              giaTien: 20000,
              urlHinhAnh: [
                'https://ytamduong.vn/wp-content/uploads/2017/11/ga-ham-2.jpg'
              ]),
          soLuong: 5),
    ];
    return ListViewFood(
      listChiTietThucPham: listChiTietThucPham,
    );
  }
}

  

// class SelectCategoryView extends StatelessWidget {
//   final int numCustomer;
//   final int numTable;
//   final int? maHoaDon;
//   const SelectCategoryView(
//       {Key? key,
//       required this.numTable,
//       required this.numCustomer,
//       this.maHoaDon})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final _viewModel = Provider.of<SelectCategoryViewModel>(context);

//     if (!_viewModel.getIsInit()) {
//       _viewModel.init();
//     }

//     List<ChiTietThucPham> listChiTietThucPhamHomNay =
//         _viewModel.getListChiTietThucPham();

//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: buildAppBar(context: context, title: 'YÊU CẦU ĐẶT MÓN'),
//       backgroundColor: kPrimaryLightColor,
//       body: Column(
//         children: [
//           Center(
//             child: Container(
//               margin: EdgeInsets.symmetric(vertical: size.width * 0.05),
//               color: Colors.white,
//               width: size.width * 0.9,
//               height: size.height * 0.1,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.people,
//                     color: kPrimaryColor,
//                     size: size.width * 0.1,
//                   ),
//                   SizedBox(width: size.width * 0.01),
//                   Text(
//                     '$numCustomer',
//                     style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black),
//                   ),
//                   SizedBox(width: size.width * 0.3),
//                   Icon(
//                     Icons.chair,
//                     color: kPrimaryColor,
//                     size: size.width * 0.1,
//                   ),
//                   SizedBox(width: size.width * 0.01),
//                   Text(
//                     '$numTable',
//                     style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Text(
//               listChiTietThucPhamHomNay.length.toString() + ' món ăn sẵn sàng'),
//           listChiTietThucPhamHomNay.length > 0
//               ? ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: listChiTietThucPhamHomNay.length,
//                   padding: EdgeInsets.all(size.width * 0.05),
//                   itemBuilder: (BuildContext context, int index) {
//                     ChiTietThucPham item = listChiTietThucPhamHomNay[index];
//                     int amount = _viewModel.getAmoutFoodOrder(index);
//                     return Container(
//                       padding: EdgeInsets.all(size.width * 0.02),
//                       color: Colors.white,
//                       width: size.width * 1,
//                       height: size.height * 0.15,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Image.network(
//                             item.thucPham.urlHinhAnh![0],
//                             fit: BoxFit.cover,
//                             height: size.height * 0.1,
//                             width: size.width * 0.2,
//                           ),
//                           SizedBox(width: size.width * 0.01),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 width: size.width * 0.35,
//                                 child: Text(
//                                   item.thucPham.ten!,
//                                   style: const TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.black),
//                                 ),
//                               ),
//                               SizedBox(height: size.height * 0.01),
//                               Text(
//                                 NumberFormat('###,###')
//                                         .format(item.thucPham.giaTien) +
//                                     'đ',
//                                 style: const TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.normal,
//                                     color: Colors.blueGrey),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               IconButton(
//                                 onPressed: () {
//                                   if (amount > 0) {
//                                     _viewModel.setAmoutFoodOrder(
//                                         index, amount - 1);
//                                   }
//                                 },
//                                 icon: Icon(Icons.remove_circle_outlined),
//                                 color: (amount > 0)
//                                     ? kPrimaryColor
//                                     : Colors.blueGrey,
//                                 iconSize: size.width * 0.07,
//                               ),
//                               Text(
//                                 amount.toString(),
//                                 style: const TextStyle(
//                                     fontSize: 16, color: Colors.black),
//                               ),
//                               IconButton(
//                                 onPressed: () {
//                                   if (amount < item.soLuong) {
//                                     _viewModel.setAmoutFoodOrder(
//                                         index, amount + 1);
//                                   }
//                                 },
//                                 icon: Icon(Icons.add_circle_outlined),
//                                 color: (amount < item.soLuong)
//                                     ? kPrimaryColor
//                                     : Colors.blueGrey,
//                                 iconSize: size.width * 0.07,
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     );
//                   },
//                 )
//               : const Center(child: Text('Không có món ăn sẵn sàng')),
//           Expanded(
//             child: Align(
//               alignment: Alignment.bottomCenter,
//               child: Row(
//                 children: [
//                   Container(
//                     color: Colors.white,
//                     width: size.width * 0.5,
//                     height: size.height * 0.05,
//                     alignment: Alignment.center,
//                     child: Text(
//                       'Tổng tiền: ' +
//                           _viewModel.getToTalPrice().toString() +
//                           'đ',
//                       style: const TextStyle(
//                           fontWeight: FontWeight.bold, fontSize: 16),
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       showConfirmDialog(context, () {
//                         _viewModel.navigateToHoaDon(
//                             soNguoi: numCustomer,
//                             ban: numTable,
//                             context: context);
//                       }, 'Bạn có xác nhận đặt món');
//                     },
//                     child: Container(
//                       color: Colors.black,
//                       width: size.width * 0.5,
//                       height: size.height * 0.06,
//                       alignment: Alignment.center,
//                       child: const Text(
//                         'Xác Nhận',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
