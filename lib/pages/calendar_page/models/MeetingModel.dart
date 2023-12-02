import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../to_do_list/models/to_do_list_model.dart';

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  String getSubject(int index) {
    print(_getMeetingData(index).title);
    return _getMeetingData(index).title;
  }

  @override
  DateTime getStartTime(int index) {
    print(_getMeetingData(index).from);
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }
    return meetingData;
  }
}

class Meeting {
  DateTime from;
  DateTime to;
  String title;
  Color background;
  bool isAllDay;
  List<ToDoListModel> toDoLists;

  Meeting(
      {required this.from,
      required this.to,
      required this.title,
      required this.background,
      required this.isAllDay,
      required this.toDoLists});

  Meeting.fromJson(Map<String, dynamic> json)
      : from = DateTime.parse(json["from"]),
        to = DateTime.parse(json["to"]),
        title = json["title"],
        background = Color(json["background"]),
        isAllDay = json["isAllDay"],
        toDoLists = (json["toDoLists"] as List<dynamic>)
            .map((task) => ToDoListModel.fromJson(task))
            .toList();

  Map toJson() {
    List<Map> list = [];

    for (var task in toDoLists) {
      list.add(task.toJson());
    }
    return {
      "from": from.toIso8601String(),
      "to": to.toIso8601String(),
      "title": title,
      "background": background.value,
      "isAllDay": isAllDay,
      "toDoLists": list,
    };
  }
}
