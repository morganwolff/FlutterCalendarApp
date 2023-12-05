import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/pages/calendar_page/models/MeetingModel.dart';
import 'package:flutter_calendar_app/pages/calendar_page/viewmodels/CalendarMeetingProvider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'CalendarEventDetailsPage.dart';
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
            const SizedBox(
              height: 100,
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text('Flutter Calendar APP',
                    style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
            ),
            const DrawerItemWidget(
                icon: Icons.view_agenda_outlined,
                text: 'Planning',
                view: CalendarView.schedule,
                index: 0),
            const DrawerItemWidget(
              icon: Icons.calendar_view_day_outlined,
              text: 'Day',
              view: CalendarView.day,
              index: 1,
            ),
            const DrawerItemWidget(
              icon: Icons.calendar_view_week_outlined,
              text: 'Week',
              view: CalendarView.week,
              index: 2,
            ),
            const DrawerItemWidget(
              icon: Icons.calendar_view_month_outlined,
              text: 'Month',
              view: CalendarView.month,
              index: 3,
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('Chung Ang'),
              value: provider.isChungAngCalendarView,
              onChanged: (bool value) {
                setState(() {
                  if (!value && !provider.isPersonalCalendarView) {
                    return;
                  }
                  provider.setChungAngCalendarView(value);
                  provider.updateSelectedCalendar();
                });
              },
              secondary: const Icon(Icons.school),
            ),
            SwitchListTile(
              title: const Text('Personal'),
              value: provider.isPersonalCalendarView,
              onChanged: (bool value) {
                setState(() {
                  if (!value && !provider.isChungAngCalendarView) {
                    return;
                  }
                  provider.setPersonalCalendarView(value);
                  provider.updateSelectedCalendar();
                });
              },
              secondary: const Icon(Icons.person),
            ),
            const Divider(),
          ],
        ),
      ),
      body: SfCalendar(
        key: ValueKey(provider.calendarView),
        view: provider.calendarView,
        firstDayOfWeek: 1,
        dataSource:
            MeetingDataSource(provider.meetingsMap[provider.selectedCalendar]!),
        onTap: calendarTapped,
        monthViewSettings: const MonthViewSettings(
            showAgenda: true,
            appointmentDisplayCount: 6,
            agendaStyle: AgendaStyle(
              backgroundColor: Colors.white60,
              appointmentTextStyle: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.white),
              dateTextStyle: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.black),
              dayTextStyle: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            )),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const MyCustomBottomSheet();
      },
    );
  }

  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {
      final Meeting appointmentDetails = details.appointments![0];

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EventDetailsPage(
          title: appointmentDetails.title,
          description: appointmentDetails.description,
          startDate: appointmentDetails.from,
          endDate: appointmentDetails.to,
          isAllDay: appointmentDetails.isAllDay,
          background: appointmentDetails.background,
          uuid: appointmentDetails.uuid,
        ),
      ));
    }
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