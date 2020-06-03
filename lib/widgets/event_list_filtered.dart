import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/calendar_events_provider.dart';

class EventListFiltered extends StatefulWidget {
  final FilterType eventsFilter;
  EventListFiltered(this.eventsFilter);
  @override
  _EventListFilteredState createState() => _EventListFilteredState();
}

class _EventListFilteredState extends State<EventListFiltered> {
  @override
  Widget build(BuildContext context) {
    final calendarData = Provider.of<CalendarEventsProvider>(context);
    // FilterType eventsFilter = calendarData.eventsFilter;
    List<Appointment> displayedEvents;
    final List<Appointment> currentMonthEvents =
        calendarData.getCurrentMonthEvents();
    final List<Appointment> futureEvents = calendarData.futureEvents;
    final List<Appointment> pastEvents = calendarData.pastEvents;

    String eventsText = 'Донации в этом месяце:';
    // FilterType eventsFilter = calendarData.eventsFilter;
  
    switch (widget.eventsFilter) {
      case FilterType.future:
        displayedEvents = futureEvents;
        eventsText = 'Предстоящие донации:';
        // print(displayedEvents);
        break;
      case FilterType.past:
        displayedEvents = pastEvents;
        eventsText = 'Прошедшие донации:';
        // print(displayedEvents);
        break;
      case FilterType.current:
        displayedEvents = currentMonthEvents;
        // print(displayedEvents);
        break;
      default:
        displayedEvents = currentMonthEvents;
        eventsText = 'Донации в этом месяце:';
        // print(displayedEvents);
        break;
    }

    return (displayedEvents.isNotEmpty)
        ? Column(
            children: <Widget>[
              Container(
                child: Text(
                  eventsText,
                  style: TextStyle(fontSize: 20),
                ),
                margin: EdgeInsets.symmetric(vertical: 10),
              ),
              Expanded(
                child: Scrollbar(
                  child: ListView(
                    children: displayedEvents
                        .map(
                          (event) => Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            elevation: 3,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Theme.of(context).accentColor,
                                radius: 20,
                                child:
                                    // Icon(
                                    // Icons.event_available,
                                    // size: 30,
                                    // color: Colors.white,
                                    Image(
                                  image: AssetImage(
                                      'assets/images/blood_drop.png'),
                                  height: 25,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(DateFormat('d MMMM y, EEEE', 'ru')
                                  .format(event.day)),
                              subtitle: Text(event.event[0]),
                              trailing: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  Provider.of<CalendarEventsProvider>(context,
                                          listen: false)
                                      .removeEvent(event.day);
                                },
                              ),
                            ),
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
