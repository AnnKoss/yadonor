import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/calendar_appointments_provider.dart';
import '../providers/calendar_screen_provider.dart';
import '../models/appointment-item.dart';
import 'appointment_card.dart';

class AppointmentListFiltered extends StatefulWidget {
  final FilterType appointmentsFilter;
  AppointmentListFiltered(this.appointmentsFilter);

  @override
  _AppointmentListFilteredState createState() => _AppointmentListFilteredState();
}

class _AppointmentListFilteredState extends State<AppointmentListFiltered> {
  @override
  Widget build(BuildContext context) {
    // final calendarAppointmentsData = Provider.of<CalendarAppointmentsProvider>(context);
    final calendarScreenData = Provider.of<CalendarScreenProvider>(context);
    // calendarScreenData.displayFilteredAppointments(widget.appointmentsFilter);

    List<Appointment> displayedAppointments = calendarScreenData.displayedAppointments;

    String appointmentsText = 'Донации в этом месяце:';
    // FilterType appointmentFilter = calendarData.appointmentFilter;

    switch (widget.appointmentsFilter) {
      case FilterType.future:
        displayedAppointments = calendarScreenData.getFutureAppointments();
        appointmentsText = 'Предстоящие донации:';
        // print(displayedAppointments);
        break;
      case FilterType.past:
        displayedAppointments = calendarScreenData.getPastAppointments();
        appointmentsText = 'Прошедшие донации:';
        // print(displayedAppointments);
        break;
      case FilterType.current:
        displayedAppointments = calendarScreenData.getCurrentMonthAppointments();
        // print(displayedAppointments);
        break;
      default:
        displayedAppointments = calendarScreenData.getCurrentMonthAppointments();
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
                            ),
                            // ListTile(
                            //   leading: CircleAvatar(
                            //     backgroundColor: Theme.of(context).accentColor,
                            //     radius: 20,
                            //     child:
                            //         // Icon(
                            //         // Icons.event_available,
                            //         // size: 30,
                            //         // color: Colors.white,
                            //         Image(
                            //       image: AssetImage(
                            //           'assets/images/blood_drop.png'),
                            //       height: 25,
                            //       color: Colors.white,
                            //     ),
                            //   ),
                            //   title: Text(DateFormat('d MMMM y, EEEE', 'ru')
                            //       .format(appointment.day)),
                            //   subtitle: Text(appointment.event),
                            //   trailing: IconButton(
                            //     icon: Icon(Icons.close),
                            //     onPressed: () {
                            //       Provider.of<CalendarAppointmentsProvider>(context,
                            //               listen: false)
                            //           .removeAppointment(appointment.day);
                            //     },
                            //   ),
                            // ),
                          ),
                          // ),
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
