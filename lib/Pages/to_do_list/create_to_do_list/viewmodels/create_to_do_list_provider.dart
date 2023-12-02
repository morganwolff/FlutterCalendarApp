import 'package:flutter/cupertino.dart';
import 'package:flutter_calendar_app/pages/to_do_list/models/to_do_task.dart';

import '../../models/to_do_list_model.dart';

class CreateToDoListProvider extends ChangeNotifier {

  String _name = "";

  String _title = "";

  List<ToDoTask> _tasks = [];

  List<ToDoTask> get tasks => _tasks;
  String get name => _name;
  String get title => _title;

  void setTasks(List<ToDoTask> list) {
    _tasks = list;
  }

  void setTitle(String value, bool notify) {
    _title = value;
    if (notify) {
      notifyListeners();
    }
  }

  void setName(String value) {
    _name = value;
    notifyListeners();
  }

  void reset() {
    _tasks.clear();
    _title = "";
    _name = "";
    notifyListeners();
  }

  void addTask(ToDoTask newTask) {
    _tasks.add(newTask);
    notifyListeners();
  }

  void removeTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }

  void changeTaskName(int index, String value) {
    _tasks[index].task = value;
    notifyListeners();
  }

}