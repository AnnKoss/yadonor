import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../providers/calendar_events_provider.dart';

import '../widgets/event_list_filtered.dart';
import '../widgets/calendar.dart';
import '../widgets/button.dart';
import './calendar_add_screen.dart';
import '../widgets/main_drawer.dart';
// import '../widgets/build_shadow_container.dart';

class CalendarScreen extends StatefulWidget {
  static const routeName = '/calendar';

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  FilterType eventsFilter = FilterType.current;

  @override
  Widget build(BuildContext context) {
    final calendarData = Provider.of<CalendarEventsProvider>(context);
    print('build');

    void selectFilter(FilterType result) {
      setState(() {
        eventsFilter = result;
      });
      print(eventsFilter);
      if (eventsFilter == FilterType.current) {
        calendarData.changeVisibleDates(
            DateTime(DateTime.now().year, DateTime.now().month, 1));
        calendarData.getCurrentMonthEvents();
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
      body: (eventsFilter == FilterType.current)
          // ? Text('current')
          // : Text('not current'),
          ? Column(
              children: <Widget>[
                Card(
                  elevation: 3,
                  margin: EdgeInsets.only(top: 10),
                  child: Calendar(),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: EventListFiltered(eventsFilter),
                ),
              ],
            )
          : EventListFiltered(eventsFilter),
      // button(
      //   context: context,
      //   onPressed: () => ,
      //   buttonText: isFutureDate ? 'Запланировать' : 'Добавить',
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            // Provider.of<CalendarProvider>(context).isCorrectDate ?
            Provider.of<CalendarEventsProvider>(context).addEvent,
        // : null,
        backgroundColor: Provider.of<CalendarEventsProvider>(context).isAvaliableDate
            ? Theme.of(context).accentColor
            : Color(0xffed6056),
        elevation: 5,
        child: Icon(Icons.add),
      ),
    );
  }
}
