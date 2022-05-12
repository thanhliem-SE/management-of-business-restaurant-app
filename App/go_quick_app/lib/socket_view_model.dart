import 'package:flutter/cupertino.dart';
import 'package:go_quick_app/models/nhan_vien.dart';
import 'package:go_quick_app/views/response_order/response_order_view_model.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketViewModel extends ChangeNotifier {
  WebSocketChannel channel = IOWebSocketChannel.connect(
    Uri(scheme: "ws", host: "192.168.1.8", port: 8080, path: "/socket"),
  );

  void sendMessage(String role, String data) {
    String message = '$role:$data';
    channel.sink.add(message);
  }

  void getMessage(NhanVien nhanVien) {
    channel.stream.listen((message) {
      List<String> split = message.toString().split(':');
      String role = split[0];
      String data = split[1];

      print(message);

      if (nhanVien.taiKhoan!.quyen == 'role' ||
          nhanVien.taiKhoan!.quyen == 'QUANLY') {
        print("ABC");
        switch (data) {
          case 'Có yêu cầu đặt món mới':
            print("XYZ");
            ResponseOrderViewModel().init();
        }
      }
    });
  }
}
