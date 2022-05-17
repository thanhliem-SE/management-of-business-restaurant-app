import 'package:flutter/material.dart';

class AddFoodFormViewModel extends ChangeNotifier {
  bool intiialized = false;

  bool get getIntiialized => this.intiialized;

  set setIntiialized(bool intiialized) => this.intiialized = intiialized;
}
