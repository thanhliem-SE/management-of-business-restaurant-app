import 'package:flutter/foundation.dart';

class RequestOrderViewModel extends ChangeNotifier {
  int? _numCustomer;
  int? _numTable;

  setNumCustomer(int? numCustomer) {
    _numCustomer = numCustomer;
    notifyListeners();
  }

  getNumCustomer() => _numCustomer;

  setNumTable(int? numTable) {
    _numTable = numTable;
    notifyListeners();
  }

  getNumTable() => _numTable;
}
