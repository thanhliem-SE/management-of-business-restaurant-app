import 'package:flutter/material.dart';
import 'package:go_quick_app/app.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/nhan_vien.dart';
import 'package:go_quick_app/models/tai_khoan.dart';
import 'package:go_quick_app/models/thong_ke_mon_an.dart';
import 'package:go_quick_app/services/notification_service.dart';
import 'package:go_quick_app/socket_view_model.dart';
import 'package:go_quick_app/utils/constants.dart';
import 'package:go_quick_app/views/add_food_form/add_food_form_view_model.dart';
import 'package:go_quick_app/views/bill/bill_view_model.dart';
import 'package:go_quick_app/views/confirm_food/confirm_add_food_view_model.dart';
import 'package:go_quick_app/views/food_detail/food_detail_view_model.dart';
import 'package:go_quick_app/views/home/home_view_model.dart';
import 'package:go_quick_app/views/login/login_view_model.dart';
import 'package:go_quick_app/views/manage_account/manage_account_view_model.dart';
import 'package:go_quick_app/views/manage_food/manage_food_view_model.dart';
import 'package:go_quick_app/views/manage_food/manager_all_food_view_model.dart';
import 'package:go_quick_app/views/manage_table/manage_table_view_model.dart';
import 'package:go_quick_app/views/payment/payment_view_model.dart';
import 'package:go_quick_app/views/request_order/request_order_view_model.dart';
import 'package:go_quick_app/views/response_order/response_order_view_model.dart';
import 'package:go_quick_app/views/return_order_customer/return_order_customer_view_model.dart';
import 'package:go_quick_app/views/select_category/select_category_view_model.dart';
import 'package:go_quick_app/views/sign_up/sign_up_viewmodel.dart';
import 'package:go_quick_app/views/thong_ke/thong_ke_view_model.dart';
import 'package:go_quick_app/views/thong_ke/widget/thong_ke_mon_an_view.dart';
import 'package:go_quick_app/views/thong_ke/widget/thong_ke_mon_an_view_model.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'views/manage_payment/manage_payment_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  tz.initializeTimeZones();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(TaiKhoanAdapter());
  Hive.registerAdapter(NhanVienAdapter());
  await Hive.openBox('signed');
  runApp(const MyApp());
  // SocketViewModel.getMessage();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => BillViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ManageTableViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => RequestOrderViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => SelectCategoryViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ResponseOrderViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => SignUpViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ManageFoodViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ManageAllFoodViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => SocketViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => PayMentViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ManagePayMentViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ReturnOrderCustomerViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => FoodDetailViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddFoodFormViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ConfirmAddFoodViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ManageAccountViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThongKeViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThongKeMonAnViewModel(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: appTitle,
          theme: ThemeData(
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: Colors.white,
          ),
          home: const GoQuickApp()),
    );
  }
}

// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:flutter/material.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     const title = 'WebSocket Demo';
//     return const MaterialApp(
//       title: title,
//       home: MyHomePage(
//         title: title,
//       ),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({
//     Key? key,
//     required this.title,
//   }) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final TextEditingController _controller = TextEditingController();
//   final _channel = WebSocketChannel.connect(
//     Uri.parse('ws://192.168.1.8:7070/webSocket'),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Form(
//               child: TextFormField(
//                 controller: _controller,
//                 decoration: const InputDecoration(labelText: 'Send a message'),
//               ),
//             ),
//             const SizedBox(height: 24),
//             StreamBuilder(
//               stream: _channel.stream,
//               builder: (context, snapshot) {
//                 return Text(snapshot.hasData ? '${snapshot.data}' : '');
//               },
//             )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _sendMessage,
//         tooltip: 'Send message',
//         child: const Icon(Icons.send),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }

//   void _sendMessage() {
//     if (_controller.text.isNotEmpty) {
//       _channel.sink.add(_controller.text);
//     }
//   }

//   @override
//   void dispose() {
//     _channel.sink.close();
//     _controller.dispose();
//     super.dispose();
//   }
// }
