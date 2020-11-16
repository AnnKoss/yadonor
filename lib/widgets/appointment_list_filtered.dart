import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:yadonor/domain/appointment-item.dart';
import 'package:yadonor/data/providers/calendar_screen_provider.dart';
import 'package:yadonor/ui/appointment_card.dart';
import 'package:yadonor/data/calendar/appointments_service.dart';
import 'package:yadonor/ui/calendar/calendar_bloc.dart';

///List of future, past or present [Appointment] for calendar_screen.dart according to [FilterType].
class AppointmentListFiltered extends StatefulWidget {
  final FilterType appointmentsFilter;

  AppointmentListFiltered(this.appointmentsFilter);

  @override
  _AppointmentListFilteredState createState() =>
      _AppointmentListFilteredState();
}

class _AppointmentListFilteredState extends State<AppointmentListFiltered> {
  CalendarBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc =
        CalendarBloc(CalendarState(), context.read<AppointmentsRepository>());
  }

  @override
  Widget build(BuildContext context) {
    final calendarScreenData = Provider.of<CalendarScreenProvider>(context);

    List<Appointment> displayedAppointments =
        calendarScreenData.displayedAppointments;

    String appointmentsText = 'Донации в этом месяце:';

    switch (widget.appointmentsFilter) {
      case FilterType.future:
        displayedAppointments = calendarScreenData.getFutureAppointments();
        appointmentsText = 'Предстоящие донации:';
        break;
      case FilterType.past:
        displayedAppointments = calendarScreenData.getPastAppointments();
        appointmentsText = 'Прошедшие донации:';
        break;
      case FilterType.current:
        displayedAppointments =
            calendarScreenData.getCurrentMonthAppointments();
        // print(displayedAppointments);
        break;
      default:
        displayedAppointments =
            calendarScreenData.getCurrentMonthAppointments();
        appointmentsText = 'Донации в этом месяце:';
        // print(displayedAppointments);
        break;
    }

    print('displayedAppointments: ' + displayedAppointments.toString());

    return (displayedAppointments.isNotEmpty)
        ? Column(
            children: <Widget>[
              Container(
                child: Text(
                  appointmentsText,
                  style: TextStyle(fontSize: 20),
                ),
                margin: EdgeInsets.only(top: 10),
              ),
              Expanded(
                child: Scrollbar(
                  child: ListView(
                    children: displayedAppointments
                        .map(
                          (appointment) => Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            elevation: 3,
                            child: AppointmentCard(
                              appointment: appointment,
                              hasCloseIcon: true,
                              onRemoveButtonPressed: _bloc.add(RemoveAppointmentEvent(appointment.day)),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          )
        : Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Text(
              'Выберите дату и нажмите "+", чтобы добавить донацию',
              style: TextStyle(
                color: Colors.grey,
                // fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
          );
  }
}
