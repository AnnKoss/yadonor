import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:yadonor/data/providers/calendar_appointments_provider.dart';
import 'package:yadonor/data/providers/calendar_screen_provider.dart';
import 'package:yadonor/ui/calendar/calendar_screen_data.dart';

class CalendarScreenView extends StatelessWidget {
  static const routeName = '/calendar';

  @override
  Widget build(BuildContext context) {
    return ListenableProvider<CalendarScreenProvider>(
        create: (ctx) => CalendarScreenProvider(Provider.of<CalendarAppointmentsProvider>(context).appointments),
        child: CalendarScreenData());
  }
}
