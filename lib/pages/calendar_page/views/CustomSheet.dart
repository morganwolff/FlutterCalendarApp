import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/common/components/to_do_list/list_to_do_list.dart';
import 'package:flutter_calendar_app/locals/app_locale.dart';
import 'package:flutter_calendar_app/pages/calendar_page/viewmodels/CalendarMeetingProvider.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyCustomBottomSheet extends StatefulWidget {
  final String? meetingUuid;

  const MyCustomBottomSheet({super.key, this.meetingUuid});

  @override
  State<MyCustomBottomSheet> createState() => _MyCustomBottomSheetState();
}

class _MyCustomBottomSheetState extends State<MyCustomBottomSheet> {
  @override
  void initState() {
    super.initState();
    if (widget.meetingUuid != null) {
      var provider = Provider.of<CalendarEventProvider>(context, listen: false);
      provider.loadMeetingData(widget.meetingUuid!);
    }
  }

  List<Map<String, dynamic>> colorOptions = [
    {"color": Colors.deepPurpleAccent, "name": "Purple"},
    {"color": Colors.pinkAccent, "name": "Pink"},
    {"color": Colors.red, "name": "Red"},
    {"color": Colors.orange, "name": "Orange"},
    {"color": Colors.yellowAccent, "name": "Yellow"},
    {"color": Colors.greenAccent, "name": "Light Green"},
    {"color": Colors.green, "name": "Green"},
    {"color": Colors.blueGrey, "name": "Gray"},
    {"color": Colors.blue, "name": "Default Color"},
  ];

  void createColorOption(BuildContext context) {
    colorOptions = [
      {"color": Colors.deepPurpleAccent, "name": AppLocale.purple.getString(context)},
      {"color": Colors.pinkAccent, "name": AppLocale.pink.getString(context)},
      {"color": Colors.red, "name": AppLocale.red.getString(context)},
      {"color": Colors.orange, "name": AppLocale.orange.getString(context)},
      {"color": Colors.yellowAccent, "name": AppLocale.yellow.getString(context)},
      {"color": Colors.greenAccent, "name": AppLocale.lightGreen.getString(context)},
      {"color": Colors.green, "name": AppLocale.green.getString(context)},
      {"color": Colors.blueGrey, "name": AppLocale.grey.getString(context)},
      {"color": Colors.blue, "name": AppLocale.default_color.getString(context)},
    ];
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('MM/dd/yyyy hh:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    double bottomSheetHeight = MediaQuery.of(context).size.height * 0.8;
    var provider = Provider.of<CalendarEventProvider>(context);
    createColorOption(context);

    return Container(
      height: bottomSheetHeight,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      provider.resetEventVariables();
                      Navigator.pop(context);
                    }),
                const Text("New Event",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {
                    if (widget.meetingUuid == null) {
                      provider.addEventToMeetingList();
                    } else {
                      provider.updateMeeting(widget.meetingUuid!);
                    }
                    provider.resetEventVariables();
                    Navigator.pop(context);
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
            TextField(
              controller: TextEditingController(text: provider.title) // Initialisez avec la valeur du provider
                ..selection = TextSelection.fromPosition(TextPosition(offset: provider.title.length)), // Placez le curseur à la fin du texte
              decoration: const InputDecoration(
                labelText: 'Titre',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => provider.setTitle(value)),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: TextEditingController(text: provider.description) // Initialisez avec la valeur du provider
                ..selection = TextSelection.fromPosition(TextPosition(offset: provider.description.length)), // Placez le curseur à la fin du texte
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.multiline,
              minLines: 2,
              maxLines: 5,
              onChanged: (value) =>
                  setState(() => provider.setDescription(value)),
            ),

            const SizedBox(height: 20),
            const Divider(),
            SwitchListTile(
              title: const Text('All day event'),
              value: provider.isAllDay,
              onChanged: (bool value) {
                setState(() {
                  provider.setIsAllDay(value);
                });
              },
              secondary: const Icon(Icons.timelapse),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Column(
                children: [
                  const Text("Start"),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: Row(children: [
                      const SizedBox(width: 10),
                      Text(formatDateTime(provider.combineDateTimeAndTimeOfDay(
                          provider.startDate, provider.startTime))),
                      const SizedBox(width: 20),
                      IconButton(
                        icon: const Icon(Icons.calendar_month),
                        onPressed: () => provider.selectDate(context, true),
                      ),
                      IconButton(
                        icon: const Icon(Icons.access_time_outlined),
                        onPressed: () => provider.selectTime(context, true),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Column(
                children: [
                  const Text("End"),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: Row(children: [
                      const SizedBox(width: 10),
                      Text(formatDateTime(provider.combineDateTimeAndTimeOfDay(
                          provider.endDate, provider.endTime))),
                      const SizedBox(width: 20),
                      IconButton(
                        icon: const Icon(Icons.calendar_month),
                        onPressed: () => provider.selectDate(context, false),
                      ),
                      IconButton(
                        icon: const Icon(Icons.access_time_outlined),
                        onPressed: () => provider.selectTime(context, false),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            Column(
              children: <Widget>[
                InkWell(
                  onTap: () => _showColorChoices(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Choose Color'),
                      ColoredBox(
                        color: provider.eventColor,
                        child: const SizedBox(height: 30, width: 30),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_right_rounded,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const ListToDoList(),
            const Divider(),
            GestureDetector(
              onTap: () => _showCalendarChoices(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Add to calendar'),
                  Text(provider.chungAngCalendar ? "Chung Ang" : "Personal",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCalendarChoices(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var provider = Provider.of<CalendarEventProvider>(context);
        String selectedCalendar = provider.chungAngCalendar
            ? "Chung Ang"
            : (provider.personalCalendar ? "Personal" : "");

        return AlertDialog(
          title: const Text('Choose where you want to add your new event.'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                CheckboxListTile(
                  title: Text(AppLocale.chungang.getString(context)),
                  value: selectedCalendar == "Chung Ang",
                  onChanged: (bool? value) {
                    if (value == true) {
                      setState(() {
                        selectedCalendar = "Chung Ang";
                        provider.setChungAngCalendar(true);
                        provider.setPersonalCalendar(false);
                      });
                    }
                  },
                ),
                CheckboxListTile(
                  title: Text(AppLocale.personal.getString(context)),
                  value: selectedCalendar == "Personal",
                  onChanged: (bool? value) {
                    if (value == true) {
                      setState(() {
                        selectedCalendar = "Personal";
                        provider.setPersonalCalendar(true);
                        provider.setChungAngCalendar(false);
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showColorChoices(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var provider = Provider.of<CalendarEventProvider>(context);
        return AlertDialog(
          title: const Text('Choisir une couleur'),
          content: SingleChildScrollView(
            child: Column(
              children: colorOptions
                  .map((colorOption) => CheckboxListTile(
                        title: Text(colorOption["name"]),
                        value: provider.eventColor == colorOption["color"],
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              provider.setEventColor(colorOption["color"]);
                            }
                          });
                        },
                        secondary: Container(
                          width: 24,
                          height: 24,
                          color: colorOption["color"],
                        ),
                      ))
                  .toList(),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}