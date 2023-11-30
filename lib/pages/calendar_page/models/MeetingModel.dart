import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

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

  Meeting({
    required this.from,
    required this.to,
    required this.title,
    required this.background,
    required this.isAllDay});
}