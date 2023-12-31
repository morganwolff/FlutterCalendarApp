import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/locals/cache.dart';
import 'package:flutter_calendar_app/locals/local_storage.dart';
import 'package:flutter_calendar_app/pages/calendar_page/models/MeetingModel.dart';
import 'package:flutter_calendar_app/pages/to_do_list/models/to_do_task.dart';

import '../../to_do_list/models/to_do_list_model.dart';

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
      body: FutureBuilder(
        future: Future.wait([
          LocalStorage.getAllEvents(),
          Cache.getStringFromCache(Cache.studentId, Cache.studentIdTimeStamp),
        ]),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                ElevatedButton(onPressed: () {
                  setState(() {});
                }, child: const Text("Add event")),
                ElevatedButton(onPressed: () {
                  LocalStorage.deleteLocalFile("pixy1${LocalStorage.eventExtension}");
                  setState(() {});
                }, child: const Text("Remove event")),
                const Text("All files in directory of app :"),
                for (var event in snapshot.data![0].entries)
                    Text(event.key),
                const SizedBox(height: 30,),
                if (snapshot.data![1] != null)
                  Text("Student id in cache : ${snapshot.data![1]}")
                else
                  ElevatedButton(onPressed: () {
                    Cache.setStringInCache(Cache.studentId, Cache.studentIdTimeStamp, "pixyID");
                    setState(() {});
                  }, child: const Text("Add id to cache")),
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