import 'package:flutter/material.dart';

class NavigationHelper {
  static clearAllAndNavigateTo({
    required BuildContext context,
    required Widget page,
    bool withNavBar = false,
  }) {
    Navigator.of(context, rootNavigator: !withNavBar).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) {
        return page;
      }),
      (_) => false,
    );
  }

  static push({
    required BuildContext context,
    required Widget page,
    bool withNavBar = false,
    String? routeName,
  }) {
    Navigator.of(context, rootNavigator: !withNavBar).push(
      MaterialPageRoute(
          builder: (context) {
            return page;
          },
          settings: RouteSettings(name: routeName ?? '')),
    );
  }

  static pushReplacement(
      {required BuildContext context,
      required Widget page,
      String? routeName}) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return page;
        },
        settings: RouteSettings(name: routeName ?? ''),
      ),
    );
  }
}
