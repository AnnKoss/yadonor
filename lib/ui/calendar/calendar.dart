import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:yadonor/domain/appointment-item.dart';

class Calendar extends StatefulWidget {
  final void Function(DateTime, List<dynamic>) onDaySelected;
  final void Function(DateTime, DateTime, CalendarFormat) onVisibleDaysChanged;
  final List<Appointment> appointments;

  const Calendar({
    Key key,
    @required this.onDaySelected,
    @required this.onVisibleDaysChanged,
    @required this.appointments,
  }) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController _calendarController;
  var thisMonthAppointments = {};

  bool isCorrectDate = true;

  // AppointmentsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();

    initializeDateFormatting();

    // _bloc =
    //     AppointmentsBloc(AppointmentsState(), context.read<AppointmentsRepository>());
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final calendarAppointmentsData = Provider.of<CalendarAppointmentRepository>(context);
    final Map<DateTime, List> calendarAppointments = Map.fromIterable(
        // calendarAppointmentsData.appointments,
        widget.appointments,
        key: (appointment) => appointment.day,
        value: (appointment) => [appointment.appointment]);
    print(calendarAppointments);

    return TableCalendar(
      calendarController: _calendarController,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        centerHeaderTitle: true,
        headerPadding: EdgeInsets.only(bottom: 8),
      ),
      calendarStyle: CalendarStyle(
        selectedColor: Theme.of(context).primaryColor,
        todayColor: Theme.of(context).primaryColorLight,
        markersColor: Theme.of(context).accentColor,
      ),
      startingDayOfWeek: StartingDayOfWeek.monday,
      locale: 'ru_Ru',
      onDaySelected: widget.onDaySelected,
      events: calendarAppointments,
      rowHeight: 40,
      onVisibleDaysChanged: widget.onVisibleDaysChanged,
      // (from, to, format) {
      //   Provider.of<CalendarScreenProvider>(context, listen: false)
      //       .changeVisibleDates(from);
      //   Provider.of<CalendarScreenProvider>(context, listen: false)
      //       .getCurrentMonthAppointments();
      //   // print(from);
      // },
    );
  }
}
