import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/locals/app_locale.dart';
import 'package:flutter_calendar_app/pages/to_do_list/create_to_do_list/viewmodels/create_to_do_list_provider.dart';
import 'package:flutter_calendar_app/pages/to_do_list/create_to_do_list/views/create_to_do_list.dart';
import 'package:flutter_calendar_app/pages/calendar_page/viewmodels/CalendarMeetingProvider.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';


class ToDoListName extends StatelessWidget {
  const ToDoListName({super.key, required this.name, required this.index, this.uuid});

  final int index;

  final String name;

  final String? uuid;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CalendarEventProvider>(context);
    return (
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(onPressed: () {
                showAdaptiveDialog(context: context, builder: (BuildContext context) {
                  return CreateToDoList(index: index);
                });
              }, icon: const Icon(Icons.edit)),
              IconButton(onPressed: () {
                provider.removeToDoListAt(index);
              }, icon: const Icon(Icons.delete))
            ],
          )
        ],
      )
    );
  }
}

class ListToDoList extends StatefulWidget {
  const ListToDoList({super.key, this.uuid});

  final String? uuid;

  @override
  State<ListToDoList> createState() => _ListToDoListState();
}

class _ListToDoListState extends State<ListToDoList> {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CalendarEventProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("${AppLocale.toDoLists.getString(context)} :"),
            IconButton(onPressed: () {
              showAdaptiveDialog(context: context, builder: (BuildContext context) {
                return (
                  const CreateToDoList(index: -1,)
                );
              });
            }, icon: const Icon(Icons.add))
          ],
        ),
        for (int i = 0; i < provider.toDoLists.length; i++)
          ToDoListName(name: provider.toDoLists[i].name, index: i)
      ],
    );
  }
}