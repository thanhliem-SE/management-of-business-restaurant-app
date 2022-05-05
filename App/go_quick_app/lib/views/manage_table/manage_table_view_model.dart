import 'package:flutter/cupertino.dart';

class ManageTableViewModel extends ChangeNotifier {
  List<int> _listRemoveTable = [];

  addRemoveTable(int table) {
    _listRemoveTable.add(table);
    notifyListeners();
  }

  removeRemoveTable(int table) {
    _listRemoveTable.remove(table);
    notifyListeners();
  }

  getListRemoveTable() {
    return _listRemoveTable;
  }
}
