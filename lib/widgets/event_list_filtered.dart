import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/calendar_provider.dart';

class EventListFiltered extends StatefulWidget {
  @override
  _EventListFilteredState createState() => _EventListFilteredState();
}

class _EventListFilteredState extends State<EventListFiltered> {
  @override
  Widget build(BuildContext context) {
    final calendarData = Provider.of<CalendarProvider>(context);
    final Map calendarEvents = calendarData.events;
    FilterType eventsFilter = calendarData.eventsFilter;
    List displayedEvents = calendarData.displayedEvents;
    List currentMonthEvents = calendarData.currentMonthEvents;
    String eventsText = 'Донации в этом месяце:';
    // FilterType eventsFilter = calendarData.eventsFilter;

    List futureEvents = calendarData.events.entries.where(
      (entry) {
        return entry.key.isAfter(DateTime.now().subtract(Duration(days: 1)));
      },
    ).toList();

    List pastEvents = calendarData.events.entries.where(
      (entry) {
        return entry.key.isBefore(DateTime.now());
      },
    ).toList();

    switch (eventsFilter) {
      case FilterType.future:
        displayedEvents = futureEvents;
        eventsText = 'Предстоящие донации:';
        print(displayedEvents);
        break;
      case FilterType.past:
        displayedEvents = pastEvents;
        eventsText = 'Прошедшие донации:';
        print(displayedEvents);
        break;
      case FilterType.calendar:
        displayedEvents = currentMonthEvents;
        print(displayedEvents);
        break;
      default:
        displayedEvents = currentMonthEvents;
        eventsText = 'Донации в этом месяце:';
        print(displayedEvents);
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
                                  .format(event.key)),
                              subtitle: Text(event.value[0].toString()),
                              trailing: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  Provider.of<CalendarProvider>(context,
                                          listen: false)
                                      .removeEvent(event.key);
                                  Provider.of<CalendarProvider>(context,
                                          listen: false)
                                      .updateCurrentMonthEvents();
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
