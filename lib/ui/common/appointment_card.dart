import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// import 'package:yadonor/data/providers/calendar_appointments_provider.dart';
import 'package:yadonor/domain/appointment-item.dart';
import 'package:yadonor/ui/calendar/calendar_screen_wm.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final bool hasCloseIcon;
  final void Function() onRemoveButtonPressed;

  AppointmentCard({
    @required this.appointment,
    this.hasCloseIcon,
    this.onRemoveButtonPressed
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
        onPressed: onRemoveButtonPressed,
      ) : null,
    );
  }
}
