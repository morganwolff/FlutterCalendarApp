import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'dart:io';

class CalendarEvent {

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
}

class LocalStorage {

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> getLocalFile(String name) async {
    final path = await _localPath;
    return File('$path/$name');
  }

  Future<List<File>> getAllLocalFiles() async {
    String directory = await _localPath;
    final entities = Directory(directory).listSync();
    return entities.whereType<File>().toList();
  }

  Future<void> writeEventsToFile(List<CalendarEvent> events, String filename) async {
    final file = await getLocalFile(filename);
    file.writeAsStringSync(jsonEncode(events));
  }

  Future<int> deleteLocalFile(String name) async {
    try {
      final path = await _localPath;
      final file = await getLocalFile(name);
      await file.delete();
      return 0;
    } catch (e) {
      return -1;
      }
  }

  Future<List<CalendarEvent>> getEventsFromFile(File file) async {
    try {
      final contents = await file.readAsString();
      final List<dynamic> list = jsonDecode(contents);
      final List<CalendarEvent> res = [];
      for (var event in list) {
        res.add(event);
      }
      return res;
    } catch (e) {
      return [];
    }
  }

  /*Future<Sting>

  Future<List<Event>> retrieveEventsFromFile(String filename) async {

  }*/

}