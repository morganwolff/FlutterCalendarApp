import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/locals/local_storage.dart';

class TestDirectoryStorage extends StatefulWidget {
  const TestDirectoryStorage({super.key});

  @override
  State<TestDirectoryStorage> createState() => _TestDirectoryStorageState();
}

class _TestDirectoryStorageState extends State<TestDirectoryStorage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TEST directory"),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<Map<String, List<CalendarEvent>>>(
        future: LocalStorage.getAllEvents(),
        builder: (BuildContext context, AsyncSnapshot<Map<String, List<CalendarEvent>>> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                ElevatedButton(onPressed: () {
                  LocalStorage.writeEventsToFile([const CalendarEvent(nb: 10, name: "pixy")], "pixy1");
                  setState(() {});
                }, child: const Text("Add event")),
                ElevatedButton(onPressed: () {
                  LocalStorage.deleteLocalFile("pixy1${LocalStorage.eventExtension}");
                  setState(() {});
                }, child: const Text("Remove event")),
                const Text("All files in directory of app :"),
                for (var event in snapshot.data!.entries)
                    Text(event.key),
              ],
            );
          } else {
            return const Text("Loading...");
          }
        },
      )
    );
  }
}