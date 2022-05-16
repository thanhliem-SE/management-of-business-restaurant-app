import 'package:flutter/cupertino.dart';
import 'package:go_quick_app/models/tai_khoan.dart';
import 'package:go_quick_app/views/bill/bill_view_model.dart';
import 'package:go_quick_app/views/home/home_view_model.dart';
import 'package:go_quick_app/views/manage_table/manage_table_view_model.dart';
import 'package:go_quick_app/views/request_order/request_order_view_model.dart';
import 'package:go_quick_app/views/response_order/response_order_view_model.dart';
import 'package:go_quick_app/views/select_category/select_category_view_model.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketViewModel extends ChangeNotifier {
  static WebSocketChannel channel =
      IOWebSocketChannel.connect('ws://192.168.1.8:7070/webSocket');
  bool isListened = false;
  TaiKhoan taiKhoan = TaiKhoan();

  HomeViewModel? homeViewModel = null;
  ManageTableViewModel? manageTableViewModel = null;
  ResponseOrderViewModel? responseOrderViewModel = null;
  BillViewModel? billViewModel = null;
  int maHoaDon = 0;
  SelectCategoryViewModel? selectCategoryViewModel = null;
  RequestOrderViewModel? requestOrderViewModel = null;

  setHomeViewModel(HomeViewModel homeViewModel) {
    this.homeViewModel = homeViewModel;
  }

  setManageTableViewModel(ManageTableViewModel manageTableViewModel) {
    this.manageTableViewModel = manageTableViewModel;
  }

  setResponseOrderViewModel(ResponseOrderViewModel responseOrderViewModel) {
    this.responseOrderViewModel = responseOrderViewModel;
  }

  setBillViewModel(BillViewModel billViewModel, int maHoaDon) {
    this.billViewModel = billViewModel;
    this.maHoaDon = maHoaDon;
  }

  setSelectCategoryViewModel(SelectCategoryViewModel selectCategoryViewModel) {
    this.selectCategoryViewModel = selectCategoryViewModel;
  }

  setRequestOrderViewModel(RequestOrderViewModel requestOrderViewModel) {
    this.requestOrderViewModel = requestOrderViewModel;
  }

  setTaiKhoan(TaiKhoan taiKhoan) {
    this.taiKhoan = taiKhoan;
  }

  setIsListend(bool isListened) {
    this.isListened = isListened;
  }

  getMessage() {
    isListened = true;
    try {
      channel.stream.listen((message) {
        print(message);
        handleMessage(message);
      });
    } catch (e) {
      print(e);
    }
  }

  static sendMessage(String role, String data) async {
    String message = '$role:$data';
    channel.sink.add(message);
  }

  void handleMessage(String message) {
    List<String> split = message.toString().split(':');
    String role = split[0];
    String data = split[1];

    if (taiKhoan.quyen == 'role' || taiKhoan.quyen == 'QUANLY') {
      // Có thông báo mới, cập nhật lại danh sách thông báo
      homeViewModel != null ? homeViewModel!.init() : true;

      if (['Thêm bàn', 'Xóa bàn', 'Cập nhật bàn'].contains(data)) {
        // Cập nhật màn hình quản lý bàn và đặt món
        manageTableViewModel != null ? manageTableViewModel!.init() : true;

        requestOrderViewModel != null ? requestOrderViewModel!.init() : true;
      } else if (['Cập nhật phản hồi yêu cầu đặt món', 'Yêu cầu đặt món mới']
          .contains(data)) {
        // Cập nhật màn hình phản hồi yêu cầu đặt món và hóa đơn
        responseOrderViewModel != null ? responseOrderViewModel!.init() : true;
        billViewModel != null && maHoaDon != 0
            ? billViewModel!.init(maHoaDon)
            : true;
        selectCategoryViewModel != null
            ? selectCategoryViewModel!.init()
            : true;
      }
    }
  }
}
