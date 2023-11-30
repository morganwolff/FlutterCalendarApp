import 'package:flutter_calendar_app/pages/to_do_list/models/to_do_task.dart';

class ToDoListModel {
  const ToDoListModel({required this.toDoList, required this.name});

  final String name;

  final List<ToDoTask> toDoList;

  ToDoListModel.fromJson(Map<String, dynamic> json) :
      name = json["name"],
      toDoList = json["toDoList"];

  Map toJson() => {
    "name": name,
    "toDoList": toDoList
  };
}