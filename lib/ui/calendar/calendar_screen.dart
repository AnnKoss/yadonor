import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:yadonor/data/calendar/appointments_service.dart';

import 'package:yadonor/data/providers/calendar_appointments_provider.dart';
import 'package:yadonor/data/providers/calendar_screen_provider.dart';
import 'package:yadonor/widgets/appointment_list_filtered.dart';
import 'package:yadonor/ui/calendar/calendar.dart';
import 'package:yadonor/ui/main_drawer.dart';
import 'package:yadonor/ui/calendar/calendar_bloc.dart';

class CalendarScreen extends StatefulWidget {
  static const routeName = '/calendar';

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  FilterType appointmentsFilter = FilterType.current;
  var _isLoading = false;

  CalendarBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc =
        CalendarBloc(CalendarState(), context.read<AppointmentsRepository>());
  }

  @override
  Widget build(BuildContext context) {
    // print('build');

    void selectFilter(FilterType result) {
      setState(() {
        appointmentsFilter = result;
      });
      print(appointmentsFilter);
      if (appointmentsFilter == FilterType.current) {
        Provider.of<CalendarScreenProvider>(context, listen: false)
            .changeVisibleDates(
                DateTime(DateTime.now().year, DateTime.now().month, 1));
        Provider.of<CalendarScreenProvider>(context, listen: false)
            .getCurrentMonthAppointments();
      }
    }

    // Future<void> onAddButtonPressed() async {
    //   setState(() {
    //     _isLoading = true;
    //   });
    //   // await Future.delayed(const Duration(seconds : 2));
    //   try {
    //     Provider.of<CalendarAppointmentsProvider>(context, listen: false)
    //         .addAppointment(
    //             Provider.of<CalendarScreenProvider>(context, listen: false)
    //                 .selectedDay);
    //   } catch (error) {
    //     showDialog(
    //       context: context,
    //       builder: (ctx) => AlertDialog(
    //         content: Text('Ошибка: "${error.toString()}"'),
    //         actions: <Widget>[
    //           FlatButton(
    //             onPressed: () => Navigator.of(ctx).pop(),
    //             child: Text('Закрыть'),
    //           )
    //         ],
    //       ),
    //     );
    //   }
    //   {
    //     setState(
    //       () {
    //         _isLoading = false;
    //       },
    //     );
    //   }
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'КАЛЕНДАРЬ ДОНАЦИЙ',
          style: Theme.of(context).textTheme.title,
        ),
        actions: <Widget>[
          PopupMenuButton<FilterType>(
            onSelected: selectFilter,
            itemBuilder: (context) => <PopupMenuEntry<FilterType>>[
              PopupMenuItem<FilterType>(
                value: FilterType.future,
                child: Text('Предстоящие донации'),
              ),
              PopupMenuDivider(),
              PopupMenuItem<FilterType>(
                value: FilterType.past,
                child: Text('Прошедшие донации'),
              ),
              PopupMenuDivider(),
              PopupMenuItem<FilterType>(
                value: FilterType.current,
                child: Text('Показать календарь'),
              ),
            ],
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
              children: <Widget>[
                Container(
                  child: (appointmentsFilter == FilterType.current)
                      ? Card(
                          elevation: 3,
                          margin: EdgeInsets.only(top: 10),
                          child: Calendar(
                            onDaySelected: (day, appointments) {
                              _bloc.add(SelectDayEvent(day, appointments));
                            },
                            onVisibleDaysChanged: (from, to, format) {
                              _bloc.add(
                                  ChangeVisibleDatesEvent(from, to, format));
                            },
                            appointments: _bloc.add(GetAppointmentsEvent),
                          ),
                        )
                      : SizedBox(height: 0),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: (!_isLoading)
                      ? AppointmentListFiltered(appointmentsFilter)
                      : Stack(
                          children: <Widget>[
                            AppointmentListFiltered(appointmentsFilter),
                            Container(
                                width: double.infinity,
                                height: double.infinity,
                                color: Color(0xffffff).withOpacity(0.3)),
                            Center(child: CircularProgressIndicator()),
                          ],
                        ),
                ),
              ],
            ),
      // button(
      //   context: context,
      //   onPressed: () => ,
      //   buttonText: isFutureDate ? 'Запланировать' : 'Добавить',
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            // Provider.of<CalendarProvider>(context).isCorrectDate ?
            // onAddButtonPressed,
            () => _bloc.add(AddAppointmentEvent()),
        // : null,
        backgroundColor:
            Provider.of<CalendarScreenProvider>(context).isFutureDate
                ? Theme.of(context).accentColor
                : Color(0xffed6056),
        elevation: 5,
        child: Icon(Icons.add),
      ),
    );
  }
}
