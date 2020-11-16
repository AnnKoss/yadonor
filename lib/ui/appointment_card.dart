import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:yadonor/data/providers/calendar_appointments_provider.dart';
import 'package:yadonor/domain/appointment-item.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final bool hasCloseIcon;
  final void onRemoveButtonPressed;

  AppointmentCard({
    @required this.appointment,
    this.hasCloseIcon,
    this.onRemoveButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Future<void> onRemoveButtonPressed() async {
    //   print('try to delete');
    //   try {
    //     Provider.of<CalendarAppointmentRepository>(context, listen: false)
    //         .removeAppointment(appointment.day);
    //   } catch (error) {
    //     showDialog(
    //       context: context,
    //       builder: (ctx) => AlertDialog(
    //         content: Text('Ошибка: "${error.toString()}"'),
    //         actions: <Widget>[
    //           FlatButton(
    //             onPressed: () => Navigator.of(ctx).pop(),
    //             child: Text('Закрыть'),
    //           )
    //         ],
    //       ),
    //     );
    //   }
    // }

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
        onPressed: () => onRemoveButtonPressed,
      ) : null,
    );
  }
}
