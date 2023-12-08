import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/common/utils/chung_ang_time_converter.dart';
import 'package:flutter_calendar_app/pages/calendar_page/models/chung_ang_class_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:uuid/uuid.dart';

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
  String description;
  String uuid;
  List<ToDoListModel> toDoLists;
  bool chungAng;

  Meeting(
      {required this.from,
      required this.to,
      required this.title,
      required this.background,
      required this.isAllDay,
      required this.description,
      required this.uuid,
      required this.toDoLists,
        this.chungAng = false,
      });

  Meeting.fromJson(Map<String, dynamic> json)
      : from = DateTime.parse(json["from"]),
        to = DateTime.parse(json["to"]),
        title = json["title"],
        background = Color(json["background"]),
        isAllDay = json["isAllDay"],
        toDoLists = (json["toDoLists"] as List<dynamic>)
            .map((task) => ToDoListModel.fromJson(task))
            .toList(),
        uuid = json["uuid"],
        description = json["description"],
        chungAng = false;

  Meeting.fromChungAng(ChungAngClassModel course, int day, int month, int year)
      : title = course.coursesName,
        from = ChungAngTimeConverter.parseTimeString(year, month, day, course.startTime),
        to = ChungAngTimeConverter.parseTimeString(year, month, day, course.endTime),
        background = Colors.blue,
        chungAng = true,
        toDoLists = [],
        uuid = const Uuid().v4().toString(),
        isAllDay = false,
        description = "Building ${course.buildingNumber} / Classroom ${course.classNumber}";



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
      "uuid": uuid,
      "description": description
    };
  }
}
