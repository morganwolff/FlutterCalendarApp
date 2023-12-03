import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/locals/local_storage.dart';
import 'package:flutter_calendar_app/pages/to_do_list/models/to_do_list_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../models/MeetingModel.dart';

class CalendarEventProvider with ChangeNotifier {
  CalendarView _calendarView = CalendarView.week;
  int _selectedDrawerIndex = 2;
  bool _chungAngCalendar = false;
  bool _personalCalendar = true;

  String _title = '';
  String _description = '';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay(hour: TimeOfDay.now().hour + 1, minute: 0);
  TimeOfDay _endTime = TimeOfDay(hour: TimeOfDay.now().hour + 2, minute: 0);
  Color _eventColor = Colors.blue;
  bool _isAllDay = false;
  final List<ToDoListModel> _toDoLists = [];

  final List<Meeting> _meetings = <Meeting>[];

  // Getters
  CalendarView get calendarView => _calendarView;
  String get title => _title;
  String get description => _description;
  DateTime get startDate => _startDate;
  DateTime get endDate => _endDate;
  TimeOfDay get startTime => _startTime;
  TimeOfDay get endTime => _endTime;
  Color get eventColor => _eventColor;
  int get selectedDrawerIndex => _selectedDrawerIndex;
  bool get isAllDay => _isAllDay;
  List<Meeting> get meetingsList => _meetings;
  bool get chungAngCalendar=> _chungAngCalendar;
  bool get personalCalendar => _personalCalendar;
  List<ToDoListModel> get toDoLists => _toDoLists;

  // Setters
  void setCalendarView(CalendarView view) {
    _calendarView = view;
    notifyListeners();
  }

  void setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  void setDescription(String description) {
    _description = description;
    notifyListeners();
  }

  void setStartDate(DateTime date) {
    _startDate = date;
    notifyListeners();
  }

  void setEndDate(DateTime date) {
    _endDate = date;
    notifyListeners();
  }

  void setStartTime(TimeOfDay time) {
    _startTime = time;
    notifyListeners();
  }

  void setEndTime(TimeOfDay time) {
    _endTime = time;
    notifyListeners();
  }

  void setEventColor(Color color) {
    _eventColor = color;
    notifyListeners();
  }

  void setSelectedDrawerIndex(int index) {
    _selectedDrawerIndex = index;
    notifyListeners();
  }

  void setIsAllDay(bool value) {
    _isAllDay = value;
    notifyListeners();
  }

  void setChungAngCalendar(bool value) {
    _chungAngCalendar = value;
    notifyListeners();
  }
  void setPersonalCalendar(bool value) {
    _personalCalendar = value;
    notifyListeners();
  }

  void resetEventVariables() {
    _title = '';
    _description = '';
    _startDate = DateTime.now();
    _endDate = DateTime.now();
    _startTime = TimeOfDay(hour: TimeOfDay.now().hour + 1, minute: 0);
    _endTime = TimeOfDay(hour: TimeOfDay.now().hour + 2, minute: 0);
    _eventColor = Colors.blue;
    _isAllDay = false;
    _toDoLists.clear();
    notifyListeners();
  }

  Future<void> selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != (isStartDate ? _startDate : _endDate)) {
      if (isStartDate) {
        _startDate = picked;
      } else {
        _endDate = picked;
      }
    }
    notifyListeners();
  }

  Future<void> selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay initialTime =
    isStartTime ? _startTime : _endTime;
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (picked != null && picked != (isStartTime ? _startTime : _endTime)) {
      if (isStartTime) {
        _startTime = picked;
      } else {
        _endTime = picked;
      }
    }
    notifyListeners();
  }

  void selectColor(Color color, BuildContext context) {
    _eventColor = color;
    notifyListeners();
  }

  DateTime combineDateTimeAndTimeOfDay(DateTime date, TimeOfDay time) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  Future<bool> getMeetingFromLocalStorage() async {
    if (_meetings.isEmpty) {
      final events = await LocalStorage.getAllEvents();
      for (var calendar in events.entries) {
        for (var meeting in calendar.value) {
          print(meeting.toJson().toString());
          _meetings.add(meeting);
        }
        break; //I only want to get the first calendar since multiple calendar is not yet implemented
      }
    }
    return true;
  }

  void addEventToMeetingList() {
    const filename = "calendar1"; //to be changed in the future for multiple calendars
    final DateTime startTime = combineDateTimeAndTimeOfDay(_startDate, _startTime);
    final DateTime endTime = combineDateTimeAndTimeOfDay(_endDate, _endTime);
    meetingsList.add(
        Meeting(
            from: startTime,
            to: endTime,
            title: _title,
            background: _eventColor,
            isAllDay: _isAllDay,
            toDoLists: List.from(_toDoLists),
        )
    );
    LocalStorage.writeEventsToFile(meetingsList, filename);
    notifyListeners();
  }

  void removeEventToList(int index) {
    // TODO: Implement the function
  }

  void addToDoList(ToDoListModel list) {
    _toDoLists.add(list);
    notifyListeners();
  }

  void replaceToDoList(ToDoListModel list, int index) {
    _toDoLists[index] = list;
    notifyListeners();
  }

  void changeBoolOfTask(int indexMeeting, int indexToDoList, int indexTask, bool value) {
      _meetings[indexMeeting].toDoLists[indexToDoList].toDoList[indexTask].completed = value;
      notifyListeners();
  }
}
