import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/pages/calendar_page/viewmodels/CalendarMeetingProvider.dart';
import 'package:flutter_calendar_app/pages/to_do_list/to_do_list_module/views/to_do_list_module.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'CustomSheet.dart';



class EventDetailsPage extends StatelessWidget {
  final String uuid;

  EventDetailsPage({
    Key? key,
    required this.uuid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CalendarEventProvider>(context);
    Map<String, int> indexes = provider.findAllMeetingOccurrences(uuid);
    if (indexes.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () {
                provider.loadMeetingData(uuid);

                showModalBottomSheet(
                  context: context,
                  builder: (context) => MyCustomBottomSheet(meetingUuid: uuid),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                Navigator.pop(context);
                provider.deleteMeeting(uuid);
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: ColoredBox(
                      color: (provider.meetingsMap[provider
                          .selectedCalendar]![indexes[provider
                          .selectedCalendar]!].background),
                      child: const SizedBox(height: 30, width: 30),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                    child: Column(
                      children: [
                        Text(
                            (provider.meetingsMap[provider
                                .selectedCalendar]![indexes[provider
                                .selectedCalendar]!].title),
                            style: const TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold)
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Icon(Icons.access_time_outlined),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                    child: Column(
                      children: [
                        Text(
                          (provider.meetingsMap[provider
                              .selectedCalendar]![indexes[provider
                              .selectedCalendar]!].isAllDay)
                              ? DateFormat('EEE, MM/dd/y').format((provider
                              .meetingsMap[provider
                              .selectedCalendar]![indexes[provider
                              .selectedCalendar]!].from))
                              : DateFormat('EEE, MM/dd/y').add_jm().format(
                              (provider.meetingsMap[provider
                                  .selectedCalendar]![indexes[provider
                                  .selectedCalendar]!].from)),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),

                        Text(
                          (provider.meetingsMap[provider
                              .selectedCalendar]![indexes[provider
                              .selectedCalendar]!].isAllDay)
                              ? ''
                              : DateFormat('EEE, MM/dd/y').add_jm().format(
                              (provider.meetingsMap[provider
                                  .selectedCalendar]![indexes[provider
                                  .selectedCalendar]!].to)),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Icon(Icons.menu),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                      child: Text(
                          (provider.meetingsMap[provider
                              .selectedCalendar]![indexes[provider
                              .selectedCalendar]!].description),
                          softWrap: true, style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
                const Divider(),
                for (int i = 0; i < provider.meetingsMap[provider.selectedCalendar]![indexes[provider.selectedCalendar]!].toDoLists.length; i++)
                    ToDoListModule(indexMeeting: indexes[provider.selectedCalendar]!, indexToDoList: i)
            ],
          ),
        ),
      );
    } else {
      return const Scaffold(
        body: Text("No event"),
      );
    }
  }
}
