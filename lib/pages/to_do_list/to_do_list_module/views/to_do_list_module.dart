import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/locals/app_locale.dart';
import 'package:flutter_calendar_app/pages/calendar_page/viewmodels/CalendarMeetingProvider.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';

import '../../../../locals/local_storage.dart';

class FieldModifyTask extends StatefulWidget {
  const FieldModifyTask(
      {super.key,
      required this.index,
      required this.indexToDoList,
      required this.indexMeeting});

  final int indexMeeting;

  final int indexToDoList;

  final int index;

  @override
  State<FieldModifyTask> createState() => _FieldModifyTaskState();
}

class _FieldModifyTaskState extends State<FieldModifyTask> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CalendarEventProvider>(context);
    return Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        TextFormField(
            initialValue: provider.meetingsMap[provider.selectedCalendar]![widget.indexMeeting]
                .toDoLists[widget.indexToDoList].toDoList[widget.index].task,
            decoration: InputDecoration(
              labelText: '${AppLocale.task.getString(context)} ${widget.index + 1}',
              border: const OutlineInputBorder(),
            ),
            onChanged: (value) {
              provider.changeNameOfTask(widget.indexMeeting,
                  widget.indexToDoList, widget.index, value);
            }),
      ],
    );
  }
}

class ListTask extends StatefulWidget {
  const ListTask(
      {super.key,
      required this.index,
      required this.indexToDoList,
      required this.indexMeeting});

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
        Checkbox(
            value: provider
                .meetingsMap[provider.selectedCalendar]![widget.indexMeeting]
                .toDoLists[widget.indexToDoList]
                .toDoList[widget.index]
                .completed,
            onChanged: (value) {
              provider.changeBoolOfTask(widget.indexMeeting,
                  widget.indexToDoList, widget.index, value!);
            }),
        const SizedBox(
          width: 10,
        ),
        if (provider
                .meetingsMap[provider.selectedCalendar]![widget.indexMeeting]
                .toDoLists[widget.indexToDoList]
                .toDoList[widget.index]
                .completed ==
            false)
          Text(provider.meetingsMap[provider.selectedCalendar]![widget.indexMeeting]
              .toDoLists[widget.indexToDoList].toDoList[widget.index].task),
        if (provider
                .meetingsMap[provider.selectedCalendar]![widget.indexMeeting]
                .toDoLists[widget.indexToDoList]
                .toDoList[widget.index]
                .completed ==
            true)
          Text(
            provider.meetingsMap[provider.selectedCalendar]![widget.indexMeeting]
                .toDoLists[widget.indexToDoList].toDoList[widget.index].task,
            style: const TextStyle(decoration: TextDecoration.lineThrough),
          ),
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
    print(provider.meetingsMap[provider.selectedCalendar]![widget.index].toJson().toString());
    return Material(
        color: Colors.transparent,
        child: Container(
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        LocalStorage.deleteLocalFile(
                            "personal${LocalStorage.eventExtension}");
                        LocalStorage.deleteLocalFile(
                            "chungang${LocalStorage.eventExtension}");
                        LocalStorage.deleteLocalFile(
                            "both${LocalStorage.eventExtension}");
                      },
                      child: const Text("Remove event")),
                  for (int i = 0;
                      i < provider.meetingsMap[provider.selectedCalendar]![widget.index].toDoLists.length;
                      i++)
                    ToDoListModule(
                      indexMeeting: widget.index,
                      indexToDoList: i,
                    ),
                ],
              ),
            ),
          ),
        ));
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
  bool modify = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CalendarEventProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            modify
                ? SizedBox(
                    width: 250,
                    child: TextFormField(
                        initialValue: provider.meetingsMap[provider.selectedCalendar]![widget.indexMeeting]
                            .toDoLists[widget.indexToDoList].name,
                        decoration: InputDecoration(
                          labelText: AppLocale.title.getString(context),
                          border: const OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          provider.changeTitleOfToDoList(
                              widget.indexMeeting, widget.indexToDoList, value);
                        }),
                  )
                : Text(provider.meetingsMap[provider.selectedCalendar]![widget.indexMeeting]
                    .toDoLists[widget.indexToDoList].name),
            !modify
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        modify = true;
                      });
                    },
                    icon: const Icon(Icons.edit))
                : TextButton(
                    onPressed: () {
                      provider.saveMeetings();
                      setState(() {
                        modify = false;
                      });
                    },
                    child: Text(AppLocale.save.getString(context))),
          ],
        ),
        for (int i = 0;
            i <
                provider.meetingsMap[provider.selectedCalendar]![widget.indexMeeting]
                    .toDoLists[widget.indexToDoList].toDoList.length;
            i++)
          !modify
              ? ListTask(
                  indexToDoList: widget.indexToDoList,
                  indexMeeting: widget.indexMeeting,
                  index: i,
                )
              : FieldModifyTask(
                  index: i,
                  indexToDoList: widget.indexToDoList,
                  indexMeeting: widget.indexMeeting),
      ],
    );
  }
}
