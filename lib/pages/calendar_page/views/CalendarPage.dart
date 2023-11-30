import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/pages/calendar_page/models/MeetingModel.dart';
import 'package:flutter_calendar_app/pages/calendar_page/viewmodels/CalendarMeetingProvider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'CustomSheet.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late MeetingDataSource meetingDataSource;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CalendarEventProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Calendar'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.today),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showBottomSheet(context),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Flutter Calendar APP',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            DrawerItemWidget(
                icon: Icons.view_agenda_outlined,
                text: 'Planning',
                view: CalendarView.schedule,
                index: 0),
            DrawerItemWidget(
              icon: Icons.calendar_view_day_outlined,
              text: 'Day',
              view: CalendarView.day,
              index: 1,
            ),
            DrawerItemWidget(
              icon: Icons.calendar_view_week_outlined,
              text: 'Week',
              view: CalendarView.week,
              index: 2,
            ),
            DrawerItemWidget(
              icon: Icons.calendar_view_month_outlined,
              text: 'Month',
              view: CalendarView.month,
              index: 3,
            ),
          ],
        ),
      ),
      body: SfCalendar(
        key: ValueKey(provider.calendarView),
        view: provider.calendarView,
        firstDayOfWeek: 1,
        dataSource: MeetingDataSource(provider.meetingsList),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return MyCustomBottomSheet();
      },
    );
  }
}

class DrawerItemWidget extends StatefulWidget {
  final IconData icon;
  final String text;
  final CalendarView view;
  final int index;

  const DrawerItemWidget(
      {super.key,
      required this.icon,
      required this.text,
      required this.view,
      required this.index});

  @override
  State<DrawerItemWidget> createState() => _DrawerItemWidgetState();
}

class _DrawerItemWidgetState extends State<DrawerItemWidget> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CalendarEventProvider>(context);
    return ListTile(
      leading: Icon(widget.icon,
          color: provider.selectedDrawerIndex == widget.index
              ? Colors.blue
              : null),
      title: Text(widget.text),
      onTap: () {
        provider.setCalendarView(widget.view);
        provider.setSelectedDrawerIndex(widget.index);
        Navigator.pop(context);
      },
    );
  }
}
