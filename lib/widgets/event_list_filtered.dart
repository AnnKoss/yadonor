import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/calendar_events_provider.dart';
import '../providers/calendar_screen_provider.dart';
import './appointment_card.dart';

class EventListFiltered extends StatefulWidget {
  final FilterType eventsFilter;
  EventListFiltered(this.eventsFilter);

  @override
  _EventListFilteredState createState() => _EventListFilteredState();
}

class _EventListFilteredState extends State<EventListFiltered> {
  @override
  Widget build(BuildContext context) {
    // final calendarEventsData = Provider.of<CalendarEventsProvider>(context);
    final calendarScreenData = Provider.of<CalendarScreenProvider>(context);
    // calendarScreenData.displayFilteredEvents(widget.eventsFilter);

    List<Appointment> displayedEvents = calendarScreenData.displayedEvents;

    String eventsText = 'Донации в этом месяце:';
    // FilterType eventsFilter = calendarData.eventsFilter;

    switch (widget.eventsFilter) {
      case FilterType.future:
        displayedEvents = calendarScreenData.getFutureEvents();
        eventsText = 'Предстоящие донации:';
        // print(displayedEvents);
        break;
      case FilterType.past:
        displayedEvents = calendarScreenData.getPastEvents();
        eventsText = 'Прошедшие донации:';
        // print(displayedEvents);
        break;
      case FilterType.current:
        displayedEvents = calendarScreenData.getCurrentMonthEvents();
        // print(displayedEvents);
        break;
      default:
        displayedEvents = calendarScreenData.getCurrentMonthEvents();
        eventsText = 'Донации в этом месяце:';
        // print(displayedEvents);
        break;
    }

    print('displayedEvents: ' + displayedEvents.toString());

    return (displayedEvents.isNotEmpty)
        ? Column(
            children: <Widget>[
              Container(
                child: Text(
                  eventsText,
                  style: TextStyle(fontSize: 20),
                ),
                margin: EdgeInsets.only(top: 10),
              ),
              Expanded(
                child: Scrollbar(
                  child: ListView(
                    children: displayedEvents
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
                            //       Provider.of<CalendarEventsProvider>(context,
                            //               listen: false)
                            //           .removeEvent(appointment.day);
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
