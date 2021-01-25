﻿import 'dart:js';

import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

import 'package:yadonor/data/appointment-item.dart';
import 'package:yadonor/ui/calendar/calendar_screen_wm.dart';
import 'package:yadonor/ui/calendar/widgets/appointment_list_filtered.dart';
import 'package:yadonor/ui/calendar/calendar.dart';
import 'package:yadonor/ui/common/main_drawer.dart';

///Chooses whether to show events of the current month, all the future or all the past ones.

class CalendarScreen extends CoreMwwmWidget {
  CalendarScreen()
      : super(
          widgetModelBuilder: (context) =>
              CalendarWidgetModel.buildCalendarWM(context),
        );

  @override
  State<StatefulWidget> createState() => _CalendarScreenState();

  static const routeName = '/calendar';
}

class _CalendarScreenState extends WidgetState<CalendarWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'КАЛЕНДАРЬ ДОНАЦИЙ',
            style: Theme.of(context).textTheme.title,
          ),
          actions: <Widget>[
            PopupMenuButton<FilterType>(
              onSelected: wm.selectFilter,
              itemBuilder: (context) => <PopupMenuEntry<FilterType>>[
                // wm.popupMenu.map((item) {
                //   PopupMenuItem<FilterType>(
                //   value: item.key,
                //   child: Text(item.value),
                // );
                // }).toList(),
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
        body: EntityStateBuilder<List<Appointment>>(
          streamedState: wm.appointments,
          child: (context, appointments) {
            return Column(children: <Widget>[
              Container(
                child: (wm.appointmentsFilter == FilterType.current)
                    ? Card(
                        elevation: 3,
                        margin: EdgeInsets.only(top: 10),
                        child: Calendar(
                          onDaySelected: (day, appointments) {
                            wm.selectDay(day, appointments);
                          },
                          onVisibleDaysChanged: (from, to, format) {
                            wm.onChangeVisibleDates.accept(from);
                            //how to pass arguments from UI to WM?
                            wm.getCurrentMonthAppointments();
                          },
                          appointments: wm.appointments.value.data,
                        ),
                      )
                    : SizedBox(height: 0),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: AppointmentListFiltered(),
              ),
            ]);
          },
          loadingBuilder: (context, appointments) {
            return Column(
              children: <Widget>[
                Container(
                  child: (wm.appointmentsFilter == FilterType.current)
                      ? Card(
                          elevation: 3,
                          margin: EdgeInsets.only(top: 10),
                          child: Calendar(
                            onDaySelected: (day, appointments) {
                              wm.selectDay(day, appointments);
                            },
                            onVisibleDaysChanged: (from, to, format) {
                              setState(() {
                                wm.changeVisibleDates(from);
                              });
                              wm.getCurrentMonthAppointments();
                            },
                            appointments: [],
                          ),
                        )
                      : SizedBox(height: 0),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Stack(
                    children: <Widget>[
                      AppointmentListFiltered(),
                      Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Color(0xffffff).withOpacity(0.3)),
                      Center(child: CircularProgressIndicator()),
                    ],
                  ),
                ),
              ],
            );
          },
        ),

        // button(
        //   context: context,
        //   onPressed: () => ,
        //   buttonText: isFutureDate ? 'Запланировать' : 'Добавить',
        // ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => wm.onAddAppointmentTap,
          backgroundColor: Theme.of(context).accentColor,
          // wm.isFutureDate
          //     ? Theme.of(context).accentColor
          //     : Color(0xffed6056),
          elevation: 5,
          child: Icon(Icons.add),
        ));
  }
}
