import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:yadonor/ui/calendar_screen/widgets/appointment_list_filtered.dart';
import 'package:yadonor/ui/calendar_screen/calendar.dart';
import 'package:yadonor/ui/common/button.dart';
import 'package:yadonor/ui/common/defauld_alert_dialog.dart';
import 'package:yadonor/ui/common/main_drawer.dart';
import 'package:yadonor/ui/calendar_screen/appointments_bloc.dart';
import 'package:yadonor/domain/appointment-item.dart';
import 'package:yadonor/ui/common/appBar.dart';

class CalendarScreen extends StatefulWidget {
  static const routeName = '/calendar';

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime selectedDay = DateTime.now();

    void selectDay(DateTime day) {
      ///A handler for [onDaySelected] property of Calendar widget.
      if (day != null) {
        selectedDay = day;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: AppBarTitile(
          'календарь донаций',
        ),
        actions: <Widget>[
          PopupMenuButton<FilterType>(
            onSelected: (result) => context.read<AppointmentsBloc>().add(
                  SelectFilterEvent(result),
                ),
            itemBuilder: (context) => <PopupMenuEntry<FilterType>>[
              PopupMenuItem<FilterType>(
                value: FilterType.future,
                child: Text(
                  'Предстоящие донации',
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem<FilterType>(
                value: FilterType.past,
                child: Text(
                  'Прошедшие донации',
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem<FilterType>(
                value: FilterType.current,
                child: Text(
                  'Показать календарь',
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: BlocBuilder<AppointmentsBloc, AppointmentsState>(
        builder: (
          context,
          state,
        ) {
          if (state is AppointmentsLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AppointmentsLoadedState) {
            return Column(
              children: <Widget>[
                Container(
                  child: (state.appointments.filter == FilterType.current)
                      ? Card(
                          elevation: 3,
                          margin: const EdgeInsets.only(top: 10),
                          child: Calendar(
                            onDaySelected: (day, _) {
                              selectDay(day);
                            },
                            onVisibleDaysChanged: (from, to, format) {
                              context.read<AppointmentsBloc>().add(
                                    ChangeVisibleDatesEvent(from),
                                  );
                            },
                            appointmentsList:
                                state.appointments.appointmentsList,
                          ),
                        )
                      : SizedBox(height: 0),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: AppointmentListFiltered(
                    state.appointments.filter,
                    state.appointments.firstVisibleDate,
                  ),
                ),
              ],
            );
          }
          if (state is AppointmentsErrorState) {
            return AlertDialog(
              title: Text(
                state.errorMessage,
              ),
              actions: [
                Button(
                  context: context,
                  onPressed: () => Navigator.of(context).pop(),
                  buttonText: 'Вернуться на главную',
                )
              ],
            );
          }
          return DefaultAlertDialog();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<AppointmentsBloc>().add(
              AddAppointmentEvent(selectedDay),
            ),
        backgroundColor: Theme.of(context).accentColor,
        elevation: 5,
        child: const Icon(Icons.add),
      ),
    );
  }
}
