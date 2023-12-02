import 'dart:convert';

import 'package:flutter_calendar_app/pages/calendar_page/models/MeetingModel.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

/*class CalendarEvent {

  const CalendarEvent({required this.nb, required this.name});

  final int nb;

  final String name;

  CalendarEvent.fromJson(Map<String, dynamic> json):
    nb = json["nb"],
    name = json["name"];

  Map toJson() => {
      "nb": nb,
      "name": name,
    };
}*/

class LocalStorage {

  static const String eventExtension = ".calendarEvent";

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> getLocalFile(String name) async {
    final path = await _localPath;
    return File('$path/$name');
  }

  static Future<List<File>> getAllLocalFiles() async {
    String directory = await _localPath;
    final entities = Directory(directory).listSync();
    return entities.whereType<File>().toList();
  }

  static Future<void> writeEventsToFile(List<Meeting> events, String filename) async {
    if (!filename.contains(eventExtension)) {
      filename = "$filename$eventExtension";
    }
    final file = await getLocalFile(filename);
    file.writeAsStringSync(jsonEncode(events));
  }

  static Future<int> deleteLocalFile(String name) async {
    try {
      final path = await _localPath;
      final file = await getLocalFile(name);
      await file.delete();
      return 0;
    } catch (e) {
      return -1;
      }
  }

  static Future<List<Meeting>> getEventsFromFile(File file) async {
    try {
      final contents = await file.readAsString();
      final List<dynamic> list = jsonDecode(contents);
      final List<Meeting> res = [];
      for (var event in list) {
        res.add(Meeting.fromJson(event));
      }
      return res;
    } catch (e) {
      return [];
    }
  }

  static Future<Map<String, List<Meeting>>> getAllEvents() async {
    final files = await getAllLocalFiles();
    final Map<String, List<Meeting>> res = {};
    String filename = "";

    for (final file in files) {
      filename = file.path.split("/").last;
      if (filename.contains(eventExtension)) {
        res[filename] = await getEventsFromFile(file);
      }
    }
    for (var tmp in res.entries) {
      for(var meeting in tmp.value) {
        print(meeting.toJson().toString());
      }
    }
    return res;
  }

}