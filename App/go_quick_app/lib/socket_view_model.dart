import 'package:flutter/cupertino.dart';
import 'package:go_quick_app/models/tai_khoan.dart';
import 'package:go_quick_app/services/notification_service.dart';
import 'package:go_quick_app/views/bill/bill_view_model.dart';
import 'package:go_quick_app/views/confirm_food/confirm_add_food_view_model.dart';
import 'package:go_quick_app/views/home/home_view_model.dart';
import 'package:go_quick_app/views/manage_payment/manage_payment_view_model.dart';
import 'package:go_quick_app/views/manage_table/manage_table_view_model.dart';
import 'package:go_quick_app/views/request_order/request_order_view_model.dart';
import 'package:go_quick_app/views/response_order/response_order_view_model.dart';
import 'package:go_quick_app/views/return_order_customer/return_order_customer_view_model.dart';
import 'package:go_quick_app/views/select_category/select_category_view_model.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketViewModel extends ChangeNotifier {
  static WebSocketChannel channel = IOWebSocketChannel.connect(
      'ws://ec2-18-141-199-16.ap-southeast-1.compute.amazonaws.com:7070/webSocket');
  // static WebSocketChannel channel =
  //     IOWebSocketChannel.connect('ws://192.168.1.8:7070/webSocket');
  bool isListened = false;
  TaiKhoan taiKhoan = TaiKhoan();

  HomeViewModel? homeViewModel = null;
  ManageTableViewModel? manageTableViewModel = null;
  ResponseOrderViewModel? responseOrderViewModel = null;
  BillViewModel? billViewModel = null;
  int maHoaDon = 0;
  SelectCategoryViewModel? selectCategoryViewModel = null;
  RequestOrderViewModel? requestOrderViewModel = null;
  ManagePayMentViewModel? managePayMentViewModel = null;
  BuildContext? managePayMentViewContext = null;
  ReturnOrderCustomerViewModel? returnOrderCustomerViewModel = null;
  BuildContext? returnOrderCustomerViewContext = null;
  ConfirmAddFoodViewModel? confirmAddFoodViewModel = null;
  BuildContext? confirmAddFoodViewContext = null;

  setConfirmAddFoodViewModel(
      ConfirmAddFoodViewModel viewModel, BuildContext context) {
    confirmAddFoodViewModel = viewModel;
    confirmAddFoodViewContext = context;
  }

  setReturnOrderCustomerViewModel(
      ReturnOrderCustomerViewModel returnOrderCustomerViewModel,
      BuildContext returnOrderCustomerViewContext) {
    this.returnOrderCustomerViewModel = returnOrderCustomerViewModel;
    this.returnOrderCustomerViewContext = returnOrderCustomerViewContext;
  }

  setManagePaymentViewModel(
      ManagePayMentViewModel value, BuildContext context) {
    managePayMentViewModel = value;
    managePayMentViewContext = context;
  }

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
        // print(message);
        handleMessage(message);
      });
    } catch (e) {
      print(e);
    }
  }

  static sendMessage(String role, String title, String body) async {
    String message = '$role:$title:$body';
    channel.sink.add(message);
  }

  void handleMessage(String message) {
    List<String> split = message.toString().split(':');
    String role = split[0];
    String title = split[1];
    String body = split[2];

    if (taiKhoan.quyen == 'role' || taiKhoan.quyen == 'QUANLY') {
      // Có thông báo mới, cập nhật lại danh sách thông báo
      homeViewModel != null ? homeViewModel!.init() : true;

      NotificationService().showNotification(1, title, body, 1);

      if (['Thêm bàn', 'Xóa bàn', 'Cập nhật bàn'].contains(title)) {
        // Cập nhật màn hình quản lý bàn và đặt món
        manageTableViewModel != null ? manageTableViewModel!.init() : true;

        requestOrderViewModel != null ? requestOrderViewModel!.init() : true;
      } else if (['Cập nhật phản hồi yêu cầu đặt món', 'Yêu cầu đặt món mới']
          .contains(title)) {
        // Cập nhật màn hình phản hồi yêu cầu đặt món và hóa đơn
        responseOrderViewModel != null ? responseOrderViewModel!.init() : true;
        billViewModel != null ? billViewModel!.init(maHoaDon) : true;
        selectCategoryViewModel != null
            ? selectCategoryViewModel!.init()
            : true;
      } else if (title == 'Yêu cầu thanh toán mới') {
        // Cập nhật màn hình quản lý thanh toán
        managePayMentViewModel != null
            ? managePayMentViewModel!.initialAsync(managePayMentViewContext!)
            : true;
      } else if (title == "Trả về hóa đơn thành công") {
        returnOrderCustomerViewModel != null
            ? returnOrderCustomerViewModel!
                .intitializedAsync(returnOrderCustomerViewContext!)
            : true;
        requestOrderViewModel != null ? requestOrderViewModel!.init() : true;
        billViewModel != null ? billViewModel!.init(maHoaDon) : true;
      } else if (title == "Thanh toán thành công") {
        managePayMentViewModel != null
            ? managePayMentViewModel!.initialAsync(managePayMentViewContext!)
            : true;
        returnOrderCustomerViewContext != null
            ? returnOrderCustomerViewModel!
                .intitializedAsync(returnOrderCustomerViewContext!)
            : true;
      } else if (title == "Thực phẩm mới cần duyệt") {
        confirmAddFoodViewModel != null
            ? confirmAddFoodViewModel!.Init(confirmAddFoodViewContext!)
            : true;
      } else if (title == "Món ăn được duyệt") {
        confirmAddFoodViewModel != null
            ? confirmAddFoodViewModel!.Init(confirmAddFoodViewContext!)
            : true;
      }
    }
  }
}
