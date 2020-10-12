import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../providers/calendar_appointments_provider.dart';
import '../providers/calendar_screen_provider.dart';

import 'appointment_list_filtered.dart';
import '../widgets/calendar.dart';
import '../widgets/button.dart';
import '../screens/calendar_add_screen.dart';
import '../widgets/main_drawer.dart';
// import '../widgets/build_shadow_container.dart';

class CalendarScreenData extends StatefulWidget {
  static const routeName = '/calendar';

  @override
  _CalendarScreenDataState createState() => _CalendarScreenDataState();
}

class _CalendarScreenDataState extends State<CalendarScreenData> {
  FilterType appointmentsFilter = FilterType.current;
  var _isLoading = false;

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

    Future<void> onAddButtonPressed() async {
      setState(() {
        _isLoading = true;
      });
      try {
        Provider.of<CalendarAppointmentsProvider>(context, listen: false).addAppointment(
            Provider.of<CalendarScreenProvider>(context, listen: false)
                .selectedDay);
      } catch (error) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            content: Text('Ошибка: "${error.toString()}"'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text('Закрыть'),
              )
            ],
          ),
        );
      }
      {
        setState(
          () {
            _isLoading = false;
          },
        );
      }
    }

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
      body: (appointmentsFilter == FilterType.current)
          ? (!_isLoading)
              ? Column(
                  children: <Widget>[
                    Card(
                      elevation: 3,
                      margin: EdgeInsets.only(top: 10),
                      child: Calendar(),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: AppointmentListFiltered(appointmentsFilter),
                    ),
                  ],
                )
              : Column(
                  children: <Widget>[
                    Card(
                      elevation: 3,
                      margin: EdgeInsets.only(top: 10),
                      child: Calendar(),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Stack(
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
                )
          : (!_isLoading)
              ? AppointmentListFiltered(appointmentsFilter)
              : Flexible(
                  fit: FlexFit.loose,
                  child: Stack(
                    children: <Widget>[
                      AppointmentListFiltered(appointmentsFilter),
                      Center(child: CircularProgressIndicator()),
                    ],
                  ),
                ),
      // button(
      //   context: context,
      //   onPressed: () => ,
      //   buttonText: isFutureDate ? 'Запланировать' : 'Добавить',
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            // Provider.of<CalendarProvider>(context).isCorrectDate ?
            onAddButtonPressed,
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
