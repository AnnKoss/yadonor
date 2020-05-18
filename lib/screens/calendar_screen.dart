import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../widgets/event_list_filtered.dart';
import '../widgets/calendar.dart';
import '../widgets/button.dart';
import './calendar_add_screen.dart';
import '../widgets/main_drawer.dart';
import '../providers/calendar_provider.dart';
// import '../widgets/build_shadow_container.dart';

// enum CalendarInfo { future, past, calendar }

class CalendarScreen extends StatefulWidget {
  static const routeName = '/calendar';

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    final calendarData = Provider.of<CalendarProvider>(context);
    FilterType eventsFilter = calendarData.eventsFilter;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'КАЛЕНДАРЬ ДОНАЦИЙ',
          style: Theme.of(context).textTheme.title,
        ),
        actions: <Widget>[
          PopupMenuButton<FilterType>(
            onSelected: Provider.of<CalendarProvider>(context, listen: false)
                .selectFilter,
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
                value: FilterType.calendar,
                child: Text('Показать календарь'),
              ),
            ],
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: (eventsFilter == FilterType.calendar)
          ? Column(
              children: <Widget>[
                Card(
                  elevation: 3,
                  margin: EdgeInsets.only(top: 10),
                  child: Calendar(),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: EventListFiltered(),
                ),
              ],
            )
          : EventListFiltered(),
      // // button(
      // //   context: context,
      // //   onPressed: () => ,
      // //   buttonText: isFutureDate ? 'Запланировать' : 'Добавить',
      // // ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            // Provider.of<CalendarProvider>(context).isCorrectDate ?
            Provider.of<CalendarProvider>(context).addEvent,
        // : null,
        backgroundColor: Provider.of<CalendarProvider>(context).isCorrectDate
            ? Theme.of(context).accentColor
            : Color(0xffed6056),
        elevation: 5,
        child: Icon(Icons.add),
      ),
    );
  }
}
