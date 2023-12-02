import 'package:flutter_calendar_app/pages/to_do_list/models/to_do_task.dart';

class ToDoListModel {
  const ToDoListModel({required this.toDoList, required this.name});

  final String name;

  final List<ToDoTask> toDoList;

  ToDoListModel.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        toDoList = (json["toDoList"] as List<dynamic>)
            .map((task) => ToDoTask.fromJson(task))
            .toList();

  Map<String, dynamic> toJson() => {
    "name": name,
    "toDoList": toDoList.map((task) => task.toJson()).toList(),
  };
}