import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/common/utils/chung_ang_time_converter.dart';
import 'package:flutter_calendar_app/locals/local_storage.dart';
import 'package:flutter_calendar_app/pages/calendar_page/models/chung_ang_class_model.dart';
import 'package:flutter_calendar_app/pages/login_page/viewmodels/LoginVewModel.dart';
import 'package:flutter_calendar_app/pages/to_do_list/models/to_do_list_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:uuid/uuid.dart';
import '../../../locals/cache.dart';
import '../models/MeetingModel.dart';

class CalendarEventProvider with ChangeNotifier {
  CalendarView _calendarView = CalendarView.week;
  int _selectedDrawerIndex = 2;
  bool _isChungAngCalendarView = false;
  bool _isPersonalCalendarView = true;
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

  Map<String, List<Meeting>> _meetingsMap = {
    "chungang": [],
    "personal": [],
    "both": []
  };

  String _selectedCalendar = "personal";

  // Getters
  String get title => _title;
  String get description => _description;
  DateTime get startDate => _startDate;
  DateTime get endDate => _endDate;
  TimeOfDay get startTime => _startTime;
  TimeOfDay get endTime => _endTime;
  Color get eventColor => _eventColor;
  bool get isAllDay => _isAllDay;
  bool get chungAngCalendar => _chungAngCalendar;
  bool get personalCalendar => _personalCalendar;
  List<ToDoListModel> get toDoLists => _toDoLists;

  CalendarView get calendarView => _calendarView;
  int get selectedDrawerIndex => _selectedDrawerIndex;
  bool get isChungAngCalendarView=> _isChungAngCalendarView;
  bool get isPersonalCalendarView => _isPersonalCalendarView;

  Map<String, List<Meeting>> get meetingsMap => _meetingsMap;
  String get selectedCalendar => _selectedCalendar;

  int _calendarKeyID = 0;

  void forceRebuildCalendar() {
    _calendarKeyID++;
    notifyListeners();
  }

  int get calendarKeyID => _calendarKeyID;


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

  void setChungAngCalendarView(bool value) {
    _isChungAngCalendarView = value;
    notifyListeners();
  }
  void setPersonalCalendarView(bool value) {
    _isPersonalCalendarView = value;
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

  void setSelectedCalendar(String value) {
    _selectedCalendar = value;
    notifyListeners();
  }

  void resetEventVariables({bool notify = true}) {
    _title = '';
    _description = '';
    _startDate = DateTime.now();
    _endDate = DateTime.now();
    _startTime = TimeOfDay(hour: TimeOfDay.now().hour + 1, minute: 0);
    _endTime = TimeOfDay(hour: TimeOfDay.now().hour + 2, minute: 0);
    _eventColor = Colors.blue;
    _isAllDay = false;
    _toDoLists.clear();
    if (notify) {
      notifyListeners();
    }
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

  void fillChungAngCalendar(List<List<ChungAngClassModel>> schedule) {
    int year = 2023;
    int month = 12;
    int day = ChungAngTimeConverter.findFirstMondayOfTheMonth(month, year);
    int i = 0;
    for(day; day <= 22; day++) {
      if (i == 7) {
        i = 0;
      }
      for (var course in schedule[i]) {
        var meeting = Meeting.fromChungAng(course, day, month, year);
        _meetingsMap["chungang"]!.add(meeting);
        _meetingsMap["both"]!.add(meeting);
      }
      i++;
    }
  }

  bool hasChungAngEvent() {
    for (var entry in _meetingsMap["chungang"]!) {
      if (entry.chungAng == true) {
        return true;
      }
    }
    return false;
  }

  Future<bool> getEvents(BuildContext context) async {
    var loginProvider = UserInfosViewModel();
    var studentId = await Cache.getStringFromCache(Cache.studentId, Cache.studentIdTimeStamp);

    await getMeetingFromLocalStorage();
    print(studentId);
    await loginProvider.fetchData(studentId!);
    var apiRes = loginProvider.get_planningWeekCau();
    print(apiRes.toString());
    print(_meetingsMap["chungang"]!.length);
    if (!hasChungAngEvent()) {
      List<List<ChungAngClassModel>> schedule = [];
      List<ChungAngClassModel> tmp = [];
      for (var day in apiRes) {
        tmp.clear();
        for (var course in day) {
          tmp.add(ChungAngClassModel.fromMap(course));
        }
        schedule.add(List.from(tmp));
      }
      fillChungAngCalendar(schedule);
    }
    return true;
  }

  Future<bool> getMeetingFromLocalStorage() async {
    // to modify
    var key = "";
    if (_meetingsMap["chungang"]!.isEmpty &&
        _meetingsMap["personal"]!.isEmpty &&
        _meetingsMap["both"]!.isEmpty) {
      final events = await LocalStorage.getAllEvents();
      print(events.entries.length);
      for (var calendar in events.entries) {
        key = calendar.key.replaceAll(LocalStorage.eventExtension, '').trim();
        print(key);
        for (var meeting in calendar.value) {
          if (_meetingsMap[key] != null) {
            _meetingsMap[key]?.add(meeting);
          }
        }
      }
    }
    return true;
  }

  void updateSelectedCalendar() {
    if (_isChungAngCalendarView && !_isPersonalCalendarView) {
      _selectedCalendar = "chungang";
    } else if (!_isChungAngCalendarView && _isPersonalCalendarView) {
      _selectedCalendar = "personal";
    } else {
      _selectedCalendar = "both";
    }
    notifyListeners();
  }

  void addEventToMeetingList() {
    final DateTime startTime = combineDateTimeAndTimeOfDay(_startDate, _startTime);
    final DateTime endTime = combineDateTimeAndTimeOfDay(_endDate, _endTime);
    print(startTime);
    var uuid = Uuid();

    if (_title.isEmpty) {
      _title = "No title";
    }
    if (_description.isEmpty) {
      _description = "No description";
    }

    Meeting newMeeting = Meeting(
        from: startTime,
        to: endTime,
        title: _title,
        background: _eventColor,
        isAllDay: _isAllDay,
        toDoLists: List.from(_toDoLists),
        description: _description,
        uuid: uuid.v4().toString(),
    );

    String mapKey = "";
    if (_chungAngCalendar) {
      mapKey = "chungang";
    } else if (_personalCalendar) {
      mapKey = "personal";
    }

    if (mapKey.isNotEmpty) {
      if (_meetingsMap.containsKey(mapKey)) {
        _meetingsMap[mapKey]!.add(newMeeting);
        _meetingsMap["both"]!.add(newMeeting);
        LocalStorage.writeEventsToFile(_meetingsMap[mapKey]!, mapKey);
        LocalStorage.writeEventsToFile(_meetingsMap["both"]!, "both");
      } else {
        return;
      }
      notifyListeners();
    }
    notifyListeners();
  }

  Map<String, int> findAllMeetingOccurrences(String uuid) {
    Map<String, int> locations = {};

    _meetingsMap.forEach((listName, meetings) {
      for (int i = 0; i < meetings.length; i++) {
        if (meetings[i].uuid == uuid) {
          locations[listName] = i;
        }
      }
    });

    if (locations.isEmpty) {
      print("FIND Meeting not found with uuid: $uuid");
    } else {
      locations.forEach((listName, index) {
      });
    }

    return locations;
  }

  void deleteMeeting(String uuid) {
    var locations = findAllMeetingOccurrences(uuid);

    if (locations.isNotEmpty) {
      locations.forEach((listName, index) {
        _meetingsMap[listName]!.removeAt(index);
        LocalStorage.writeEventsToFile(_meetingsMap[listName]!, listName);

        for (var key in locations.keys.toList()) {
          if (key == listName && locations[key]! > index) {
            locations[key] = locations[key]! - 1;
          }
        }
      });

      notifyListeners();
    } else {
      print("DELETE Meeting not found with uuid: $uuid");
    }
  }

  void loadMeetingData(String uuid, {bool notify = true}) {
    var locations = findAllMeetingOccurrences(uuid);
    if (locations.isNotEmpty) {
      String listName = locations.keys.first;
      int index = locations[listName]!;
      Meeting meetingToEdit = _meetingsMap[listName]![index];

      _title = meetingToEdit.title;
      _startDate = meetingToEdit.from;
      _endDate = meetingToEdit.to;
      _eventColor = meetingToEdit.background;
      _isAllDay = meetingToEdit.isAllDay;
      _description = meetingToEdit.description;
      _toDoLists.clear();
      _toDoLists.addAll(meetingToEdit.toDoLists);

      if (notify) {
        notifyListeners();
      }
    }
  }

  void updateMeeting(String uuid) {
    var locations = findAllMeetingOccurrences(uuid);

    if (locations.isNotEmpty) {
      locations.forEach((listName, index) {
        Meeting meetingToUpdate = _meetingsMap[listName]![index];
        meetingToUpdate.title = _title;
        meetingToUpdate.from = _startDate;
        meetingToUpdate.to = _endDate;
        meetingToUpdate.background = _eventColor;
        meetingToUpdate.isAllDay = _isAllDay;
        meetingToUpdate.description = _description;
        meetingToUpdate.toDoLists = List.from(_toDoLists);
        LocalStorage.writeEventsToFile(_meetingsMap[listName]!, listName);
      });

      notifyListeners();
    } else {
      print("UPDATE Meeting not found with uuid: $uuid");
    }
  }

  void addToDoList(ToDoListModel list) {
    _toDoLists.add(list);
    notifyListeners();
  }

  void replaceToDoList(ToDoListModel list, int index) {
    _toDoLists[index] = list;
    notifyListeners();
  }

  void removeToDoListAt(int index) {
    _toDoLists.removeAt(index);
    notifyListeners();
  }

  void changeBoolOfTask(int indexMeeting, int indexToDoList, int indexTask, bool value) {
      var uuid = _meetingsMap[_selectedCalendar]![indexMeeting].uuid;
      final indexes = findAllMeetingOccurrences(uuid);
      for (var entry in indexes.entries) {
        _meetingsMap[entry.key]![entry.value]!.toDoLists[indexToDoList].toDoList[indexTask].completed = value;
        LocalStorage.writeEventsToFile(_meetingsMap[entry.key]!, entry.key);
      }
      notifyListeners();
  }

  void changeNameOfTask(int indexMeeting, int indexToDoList, int indexTask, String value) {
    var uuid = _meetingsMap[_selectedCalendar]![indexMeeting].uuid;
    final indexes = findAllMeetingOccurrences(uuid);
    for (var entry in indexes.entries) {
      _meetingsMap[_selectedCalendar]![indexMeeting].toDoLists[indexToDoList].toDoList[indexTask].task = value;
    }
    notifyListeners();
  }

  void changeTitleOfToDoList(int indexMeeting, int indexToDoList, String value) {
    var uuid = _meetingsMap[_selectedCalendar]![indexMeeting].uuid;
    final indexes = findAllMeetingOccurrences(uuid);
    for (var entry in indexes.entries) {
      _meetingsMap[_selectedCalendar]![indexMeeting].toDoLists[indexToDoList].name = value;
    }
    notifyListeners();
  }

  void saveMeetings() {
    LocalStorage.writeEventsToFile(_meetingsMap[_selectedCalendar]!, _selectedCalendar);
    LocalStorage.writeEventsToFile(_meetingsMap["both"]!, "both");
  }
}
