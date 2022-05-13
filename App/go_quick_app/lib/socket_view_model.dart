import 'package:flutter/cupertino.dart';
import 'package:go_quick_app/models/nhan_vien.dart';
import 'package:go_quick_app/utils/helper.dart';
import 'package:go_quick_app/views/response_order/response_order_view_model.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketViewModel extends ChangeNotifier {
  static WebSocketChannel channel =
      IOWebSocketChannel.connect('ws://192.168.1.8:8080/socket');
  // Uri(scheme: "ws", host: "192.168.1.8", port: 8080, path: "/socket"),);

  sendMessage(String role, String data) async {
    String message = '$role:$data';
    channel.sink.add(message);
  }

  static void getMessage() {
    channel.stream.listen((message) {
      print(message.toString());

      //   // List<String> split = message.toString().split(':');
      //   // String role = split[0];
      //   // String data = split[1];

      //   // if (nhanVien.taiKhoan!.quyen == 'role' ||
      //   //     nhanVien.taiKhoan!.quyen == 'QUANLY') {
      //   //   print("ABC");
      //   //   switch (data) {
      //   //     case 'Có yêu cầu đặt món mới':
      //   //       print("XYZ");
      //   //       ResponseOrderViewModel().init();
      //   //   }
      //   // }
    });
  }
}
