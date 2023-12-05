import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/locals/local_storage.dart';
import 'package:flutter_calendar_app/pages/to_do_list/models/to_do_list_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:uuid/uuid.dart';
import '../models/MeetingModel.dart';

class CalendarEventProvider with ChangeNotifier {
  CalendarView _calendarView = CalendarView.week;
  int _selectedDrawerIndex = 2;
  bool _isChungAngCalendarView = true;
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
      _meetingsMap[_selectedCalendar]![indexMeeting].toDoLists[indexToDoList].toDoList[indexTask].completed = value;
      LocalStorage.writeEventsToFile(_meetingsMap[_selectedCalendar]!, _selectedCalendar);
      notifyListeners();
  }

  void changeNameOfTask(int indexMeeting, int indexToDoList, int indexTask, String value) {
    _meetingsMap[_selectedCalendar]![indexMeeting].toDoLists[indexToDoList].toDoList[indexTask].task = value;
    notifyListeners();
  }

  void changeTitleOfToDoList(int indexMeeting, int indexToDoList, String value) {
    _meetingsMap[_selectedCalendar]![indexMeeting].toDoLists[indexToDoList].name = value;
    notifyListeners();
  }

  void saveMeetings() {
    LocalStorage.writeEventsToFile(_meetingsMap[_selectedCalendar]!, _selectedCalendar);
    LocalStorage.writeEventsToFile(_meetingsMap["both"]!, "both");
  }
}
