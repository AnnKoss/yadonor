﻿import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

import 'package:yadonor/ui/calendar/calendar_screen_wm.dart';
import 'package:yadonor/data/appointment-item.dart';
import 'package:yadonor/ui/common/appointment_card.dart';

///List of future, past or present [Appointment] for calendar_screen.dart according to [FilterType].
class AppointmentListFiltered extends CoreMwwmWidget {
  AppointmentListFiltered()
      : super(
          widgetModelBuilder: (context) =>
              CalendarWidgetModel.buildCalendarWM(context),
          // Navigator.of(context)),
        );

  @override
  State<StatefulWidget> createState() => _AppointmentListFilteredState();
}

class _AppointmentListFilteredState extends WidgetState<CalendarWidgetModel> {
  // List<Appointment> displayedAppointments = [];

  @override
  Widget build(BuildContext context) {
    print('build AppointmentListFiltered');
    String appointmentsText = 'Донации в этом месяце:';

    return StreamedStateBuilder<bool>(
      streamedState: wm.isLoading,
      builder: (context, isLoading) {
        List<Appointment> displayedAppointments =
            wm.currentMonthAppointments;

        print('AppointmentListFiltered displayedAppointments: ' +
            displayedAppointments.toString());

        switch (wm.appointmentsFilter) {
          case FilterType.future:
            displayedAppointments = wm.getFutureAppointments();
            appointmentsText = 'Предстоящие донации:';
            break;
          case FilterType.past:
            displayedAppointments = wm.getPastAppointments();
            appointmentsText = 'Прошедшие донации:';
            break;
          case FilterType.current:
            displayedAppointments = wm.currentMonthAppointments;
            // print(displayedAppointments);
            break;
          default:
            displayedAppointments = wm.currentMonthAppointments;
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
                                    onRemoveButtonPressed: () {
                                      wm.onRemoveAppointmentTap();
                                      // displayedAppointments = state
                                      //     .appointmentsList
                                      //     .currentMonthAppointments(
                                      //         widget.firstVisibleDate);
                                      // context.read<AppointmentsBloc>().add(GetAppointmentsEvent());
                                    }),
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
      },
    );
  }
}