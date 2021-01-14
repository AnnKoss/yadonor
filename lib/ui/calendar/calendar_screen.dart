import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:yadonor/widgets/appointment_list_filtered.dart';
import 'package:yadonor/ui/calendar/calendar.dart';
import 'package:yadonor/ui/main_drawer.dart';
import 'package:yadonor/ui/calendar/appointments_bloc.dart';
import 'package:yadonor/domain/appointment-item.dart';

enum FilterType { future, past, current }

///Chooses whether to show events of the current month, all the future or all the past ones.

class CalendarScreen extends StatefulWidget {
  static const routeName = '/calendar';

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  DateTime firstVisibleDate = DateTime(
        /// The first date visible on the screen of current month. Used for changing displayed current month appointments in appointment_list_filtered.dart.
        DateTime.now().year,
        DateTime.now().month,
        1);
        
  FilterType appointmentsFilter = FilterType.current;

  ///is the [selectedDay] in the future (true) or in the past
  bool isFutureDate = true; 

  @override
  Widget build(BuildContext context) {
    // print('build');

    DateTime selectedDay = DateTime.now();

    void selectedDayCheck(DateTime day) {
    ///Checks if [selectedDay] is in the past or in the future.
    if (day.isAfter(DateTime.now().subtract(Duration(days: 1)))) {
      isFutureDate = true;
    } else {
      isFutureDate = false;
    }
  }

    void selectDay(DateTime day, List<Appointment> appointments) {
      ///A handler for [onDaySelected] property of Calendar widget.
      // DateTime selectedDay;
      if (day != null) {
        selectedDay = day;
      }
      selectedDayCheck(day);
      // return selectedDay;
    }

    void changeVisibleDates(DateTime from) {
      ///Changes displayed current month appointments in appointment_list_filtered.dart.
      print('changeVisibleDates from: ' + from.toString());
      setState(() {
        firstVisibleDate = from;
      });
    }

    void selectFilter(FilterType result) {
      setState(() {
        appointmentsFilter = result;
      });
      print(appointmentsFilter);
      if (appointmentsFilter == FilterType.current) {
        changeVisibleDates(
            DateTime(DateTime.now().year, DateTime.now().month, 1));
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
      body: BlocBuilder<AppointmentsBloc, AppointmentsState>(
        builder: (context, state) {
          if (state is AppointmentsLoadingState) {
            return Column(
              children: <Widget>[
                Container(
                  child: (appointmentsFilter == FilterType.current)
                      ? Card(
                          elevation: 3,
                          margin: EdgeInsets.only(top: 10),
                          child: Calendar(
                            onDaySelected: (day, appointments) {
                              selectDay(day, appointments);
                            },
                            onVisibleDaysChanged: (from, to, format) {
                              setState(() {
                                changeVisibleDates(from);
                              });

                              //getCurrentMonthAppointments
                            },
                            appointments: [],
                          ))
                      : SizedBox(height: 0),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Stack(
                    children: <Widget>[
                      AppointmentListFiltered(
                          appointmentsFilter, firstVisibleDate),
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
          }
          if (state is AppointmentsLoadedState) {
            return Column(
              children: <Widget>[
                Container(
                  child: (appointmentsFilter == FilterType.current)
                      ? Card(
                          elevation: 3,
                          margin: EdgeInsets.only(top: 10),
                          child: Calendar(
                            onDaySelected: (day, appointments) {
                              selectDay(
                                  day, state.appointmentsList.appointments);
                            },
                            onVisibleDaysChanged: (from, to, format) {
                                changeVisibleDates(from);
                            },
                            appointments: state.appointmentsList.appointments,
                          ))
                      : SizedBox(height: 0),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: AppointmentListFiltered(
                      appointmentsFilter, firstVisibleDate),
                ),
              ],
            );
          }
          return const Text('Something went wrong!');
        },
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
            () => context
                .read<AppointmentsBloc>()
                .add(AddAppointmentEvent(selectedDay)),
        // : null,
        backgroundColor: Theme.of(context).accentColor,
        // Provider.of<CalendarScreenProvider>(context).isFutureDate
        //     ? Theme.of(context).accentColor
        //     : Color(0xffed6056),
        elevation: 5,
        child: Icon(Icons.add),
      ),
    );
  }
}
