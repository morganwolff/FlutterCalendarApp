import 'package:flutter/cupertino.dart';

import '../models/to_do_list_model.dart';

class ToDoListProvider extends ChangeNotifier {

  final List<ToDoListModel> _allList = [];

  List<ToDoListModel> get allList => _allList;

  void addList(ToDoListModel newList) {
    _allList.add(newList);
    notifyListeners();
  }

  void deleteList(int index) {
    _allList.removeAt(index);
    notifyListeners();
  }

}