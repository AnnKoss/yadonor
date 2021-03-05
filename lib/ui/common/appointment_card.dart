import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:yadonor/data/appointment-item.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final bool hasCloseIcon;
  final void Function(DateTime) onRemoveButtonPressed;
  final DateTime day;

  AppointmentCard({
    @required this.appointment,
    this.hasCloseIcon,
    this.onRemoveButtonPressed,
    this.day,
  });

  @override
  Widget build(BuildContext context) {

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).accentColor,
        radius: 20,
        child:
            // Icon(
            // Icons.appointment_available,
            // size: 30,
            // color: Colors.white,
            Image(
          image: AssetImage('assets/images/blood_drop.png'),
          height: 25,
          color: Colors.white,
        ),
      ),
      title: Text(DateFormat('d MMMM y, EEEE', 'ru').format(appointment.day)),
      subtitle: Text(appointment.appointment),
      trailing: hasCloseIcon ? IconButton(
        icon: Icon(Icons.close),
        onPressed: () => onRemoveButtonPressed(day),
      ) : null,
    );
  }
}
