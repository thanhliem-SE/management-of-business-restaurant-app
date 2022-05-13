import 'package:flutter/material.dart';
import 'package:go_quick_app/app.dart';
import 'package:go_quick_app/config/palette.dart';
import 'package:go_quick_app/models/nhan_vien.dart';
import 'package:go_quick_app/models/tai_khoan.dart';
import 'package:go_quick_app/socket_view_model.dart';
import 'package:go_quick_app/utils/constants.dart';
import 'package:go_quick_app/views/bill/bill_view_model.dart';
import 'package:go_quick_app/views/home/home_view_model.dart';
import 'package:go_quick_app/views/login/login_view_model.dart';
import 'package:go_quick_app/views/manage_food/manage_food_view_model.dart';
import 'package:go_quick_app/views/manage_food/manager_all_food_view_model.dart';
import 'package:go_quick_app/views/manage_table/manage_table_view_model.dart';
import 'package:go_quick_app/views/request_order/request_order_view_model.dart';
import 'package:go_quick_app/views/response_order/response_order_view_model.dart';
import 'package:go_quick_app/views/select_category/select_category_view_model.dart';
import 'package:go_quick_app/views/sign_up/sign_up_viewmodel.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(TaiKhoanAdapter());
  Hive.registerAdapter(NhanVienAdapter());
  await Hive.openBox('signed');
  runApp(const MyApp());
  SocketViewModel.getMessage();
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
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: appTitle,
          theme: ThemeData(
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: Colors.white,
          ),
          home: GoQuickApp()),
    );
  }
}
