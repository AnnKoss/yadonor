import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/calendar_events_provider.dart';

class EventCard extends StatelessWidget {
  final Appointment appointment;

  EventCard(this.appointment);

  @override
  Widget build(BuildContext context) {
    Future<void> onRemoveButtonPressed() async {
      print('try to delete');
      try {
        Provider.of<CalendarEventsProvider>(context, listen: false)
            .removeEvent(appointment.day);
      } catch (error) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            content: Text('Ошибка: "${error.toString()}"'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text('Закрыть'),
              )
            ],
          ),
        );
      }
    }

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).accentColor,
        radius: 20,
        child:
            // Icon(
            // Icons.event_available,
            // size: 30,
            // color: Colors.white,
            Image(
          image: AssetImage('assets/images/blood_drop.png'),
          height: 25,
          color: Colors.white,
        ),
      ),
      title: Text(DateFormat('d MMMM y, EEEE', 'ru').format(appointment.day)),
      subtitle: Text(appointment.event),
      trailing: IconButton(
        icon: Icon(Icons.close),
        onPressed: onRemoveButtonPressed,
      ),
    );
  }
}
