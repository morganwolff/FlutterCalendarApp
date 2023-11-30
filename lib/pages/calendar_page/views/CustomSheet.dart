import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/pages/calendar_page/viewmodels/CalendarMeetingProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyCustomBottomSheet extends StatefulWidget {
  const MyCustomBottomSheet({super.key});

  @override
  _MyCustomBottomSheetState createState() => _MyCustomBottomSheetState();
}

class _MyCustomBottomSheetState extends State<MyCustomBottomSheet> {
  Color? selectedColor = Colors.blue;

  final List<Map<String, dynamic>> colorOptions = [
    {"color": Colors.deepPurpleAccent, "name": "Purple"},
    {"color": Colors.pinkAccent, "name": "Rose"},
    {"color": Colors.red, "name": "Rouge"},
    {"color": Colors.orange, "name": "Orange"},
    {"color": Colors.yellowAccent, "name": "Jaune"},
    {"color": Colors.greenAccent, "name": "Vert clair"},
    {"color": Colors.green, "name": "Vert"},
    {"color": Colors.blueGrey, "name": "Gris"},
    {"color": Colors.blue, "name": "Couleur par défaut"},
  ];



  @override
  Widget build(BuildContext context) {
    double bottomSheetHeight = MediaQuery.of(context).size.height * 0.8;
    var provider = Provider.of<CalendarEventProvider>(context);

    String formatDateTime(DateTime dateTime) {
      return DateFormat('MM/dd/yyyy hh:mm a').format(dateTime);
    }

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
                    provider.addEventToMeetingList();
                    provider.resetEventVariables();
                    Navigator.pop(context);
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Titre',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => provider.setTitle(value)),
            ),
            const SizedBox(height: 20),
            TextField(
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
                      Text(formatDateTime(provider.combineDateTimeAndTimeOfDay(provider.startDate, provider.startTime))),
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
            SizedBox(height: 20,),
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
            Column(
              children: <Widget>[
                InkWell(
                  onTap: () => _showColorChoices(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Choose Color'),
                      ColoredBox(
                        color: provider.eventColor,
                        child: SizedBox(height: 30, width: 30),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right_rounded,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
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
                        value: selectedColor == colorOption["color"],
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              selectedColor = colorOption["color"];
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
