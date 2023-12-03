import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/pages/calendar_page/viewmodels/CalendarMeetingProvider.dart';
import 'package:provider/provider.dart';

import '../../../../locals/local_storage.dart';

class ListTask extends StatefulWidget {
  const ListTask({super.key, required this.index, required this.indexToDoList, required this.indexMeeting});

  final int indexMeeting;

  final int indexToDoList;

  final int index;

  @override
  State<ListTask> createState() => _ListTaskState();
}

class _ListTaskState extends State<ListTask> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CalendarEventProvider>(context);
    return (Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(value: provider.meetingsList[widget.indexMeeting]
            .toDoLists[widget.indexToDoList].toDoList[widget.index].completed, onChanged: (value) {
          provider.changeBoolOfTask(widget.indexMeeting, widget.indexToDoList, widget.index, value!);
        }),
        const SizedBox(
          width: 10,
        ),
        Text(provider.meetingsList[widget.indexMeeting]
            .toDoLists[widget.indexToDoList].toDoList[widget.index].task),
      ],
    ));
  }
}

class AllToDoLists extends StatefulWidget {
  const AllToDoLists({super.key, required this.index});

  final int index;

  @override
  State<AllToDoLists> createState() => _AllToDoListsState();
}

class _AllToDoListsState extends State<AllToDoLists> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CalendarEventProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                LocalStorage.deleteLocalFile(
                    "calendar1${LocalStorage.eventExtension}");
              },
              child: const Text("Remove event")),
          for (int i = 0;
              i < provider.meetingsList[widget.index].toDoLists.length;
              i++)
            ToDoListModule(
              indexMeeting: widget.index,
              indexToDoList: i,
            ),
        ],
      ),
    );
  }
}

class ToDoListModule extends StatefulWidget {
  const ToDoListModule(
      {super.key, required this.indexMeeting, required this.indexToDoList});

  final int indexMeeting;

  final int indexToDoList;

  @override
  State<ToDoListModule> createState() => _ToDoListModuleState();
}

class _ToDoListModuleState extends State<ToDoListModule> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CalendarEventProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(provider.meetingsList[widget.indexMeeting]
                .toDoLists[widget.indexToDoList].name),
            IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
          ],
        ),
        for (int i = 0;
            i <
                provider.meetingsList[widget.indexMeeting]
                    .toDoLists[widget.indexToDoList].toDoList.length;
            i++)
          ListTask(indexToDoList: widget.indexToDoList, indexMeeting: widget.indexMeeting, index: i,),
      ],
    );
  }
}
