import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/locals/app_locale.dart';
import 'package:flutter_calendar_app/pages/calendar_page/viewmodels/CalendarMeetingProvider.dart';
import 'package:flutter_calendar_app/pages/to_do_list/create_to_do_list/viewmodels/create_to_do_list_provider.dart';
import 'package:flutter_calendar_app/pages/to_do_list/models/to_do_list_model.dart';
import 'package:flutter_calendar_app/pages/to_do_list/models/to_do_task.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';

class CreateToDoList extends StatefulWidget {
  const CreateToDoList({super.key, required this.index});

  final int index;

  @override
  State<CreateToDoList> createState() => _CreateToDoListState();
}

class _CreateToDoListState extends State<CreateToDoList> {

  final fieldText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CreateToDoListProvider>(context);
    var providerCalendar = Provider.of<CalendarEventProvider>(context);
    if (widget.index > -1) {
      provider.setTasks(providerCalendar.toDoLists[widget.index].toDoList);
      provider.setTitle(providerCalendar.toDoLists[widget.index].name, false);
    }
    return (Material(
      color: Colors.transparent,
      child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child:
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: const Icon(Icons.chevron_left),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                      Text(AppLocale.addToDoList.getString(context),
                        style:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    TextButton(
                      onPressed: () {
                        var newList = ToDoListModel(
                            toDoList: List.from(provider.tasks), name: provider.title);
                        if (widget.index > -1) {
                          providerCalendar.replaceToDoList(newList, widget.index);
                        } else {
                          providerCalendar.addToDoList(newList);
                        }
                        provider.reset();
                        Navigator.pop(context);
                      },
                      child: Text(AppLocale.save.getString(context)),
                    ),
                  ],
                ),
                TextFormField(
                    initialValue: provider.title,
                    decoration: InputDecoration(
                      labelText: AppLocale.title.getString(context),
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      provider.setTitle(value, true);
                    }),
                const SizedBox(height: 20,),
                for (int i = 0; i < provider.tasks.length; i++)
                  Column(
                    children: [
                      TextFormField(
                          initialValue: provider.tasks[i].task,
                          decoration: InputDecoration(
                            labelText: '${AppLocale.task.getString(context)} ${i + 1}',
                            border: const OutlineInputBorder(),
                          ),
                          onChanged: (value) {provider.changeTaskName(i, value);}),
                      const SizedBox(height: 20,),
                    ],
                  ),
                TextField(
                    controller: fieldText,
                    decoration: InputDecoration(
                      labelText: AppLocale.newElement.getString(context),
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      provider.setName(value);
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(onPressed: () {
                      provider.addTask(ToDoTask(task: provider.name, completed: false));
                      provider.setName("");
                      fieldText.clear();
                    }, child: Text(AppLocale.add.getString(context)))
                  ],
                )
              ]),
            ),
          )),
    ));
  }
}
