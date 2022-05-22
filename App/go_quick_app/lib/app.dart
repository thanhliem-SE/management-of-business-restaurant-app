import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:go_quick_app/amplifyconfiguration.dart';
import 'package:go_quick_app/socket_view_model.dart';
import 'package:go_quick_app/utils/helper.dart';
import 'package:go_quick_app/views/home/home_view.dart';
import 'package:go_quick_app/views/login/login_view.dart';
import 'package:provider/provider.dart';

class GoQuickApp extends StatefulWidget {
  const GoQuickApp({Key? key}) : super(key: key);

  @override
  _GoQuickAppState createState() => _GoQuickAppState();
}

class _GoQuickAppState extends State<GoQuickApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: Helper.isHasToken(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        // Kiểm tra xem có dữ liệu token lưu trong bộ nhớ ko
        if (snapshot.data == true) {
          return const HomeView();
        } else {
          return const LoginView();
        }
      },
    );
  }

  Future<void> configureAmplify() async {
    Amplify.addPlugins([AmplifyAuthCognito(), AmplifyStorageS3()]);
    try {
      await Amplify.configure(amplifyconfig);
    } catch (e) {
      print("Amplify is already configure");
    }
  }
}
