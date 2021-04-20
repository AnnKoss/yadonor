import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:yadonor/data/appointment-item.dart';

import 'package:yadonor/ui/calendar/calendar_screen.dart';
import 'package:yadonor/ui/questionary/pre_questionary_screen.dart';
import 'package:yadonor/ui/address/address_screen.dart';
import 'package:yadonor/ui/main_screen/widgets/main_screen_button.dart';
import 'package:yadonor/ui/common/main_drawer.dart';
import 'package:yadonor/ui/common/appointment_card.dart';
import 'package:yadonor/ui/main_screen/main_screen_wm.dart';
import 'package:yadonor/utils/constants.dart' as constants;

class MainScreen extends CoreMwwmWidget {
  MainScreen()
      : super(
          widgetModelBuilder: (context) => buildMainScreenWM(context),
        );

  @override
  State<StatefulWidget> createState() => _MainScreenState();

  static const routeName = '/main';
}

class _MainScreenState extends WidgetState<MainScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          constants.MAIN_SCREEN_TITLE,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      drawer: MainDrawer(),
      body: Container(
        decoration: constants.MAIN_SCREEN_BACKGROUND_DECORATION,
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 160,
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 20),
                elevation: 3,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text(
                      constants.NEAREST_DONATION_TEXT,
                      textAlign: TextAlign.center,
                    ),
                    EntityStateBuilder<Appointment>(
                      streamedState: wm.streamedState,
                      child: (context, nearestAppointment) {
                        return (nearestAppointment != null)
                            ? Container(
                                margin: const EdgeInsets.all(5),
                                width: 260,
                                child: Center(
                                  child: AppointmentCard(
                                    appointment: nearestAppointment,
                                    hasCloseIcon: false,
                                  ),
                                ),
                              )
                            : FlatButton(
                                onPressed: () => Navigator.of(context)
                                    .pushNamed(CalendarScreen.routeName),
                                child: Text(
                                    constants.SCHEDULE_NEAREST_DONATION_TEXT,
                                    style: const TextStyle(fontSize: 20)),
                                textColor: Theme.of(context).accentColor,
                              );
                      },
                      loadingChild: Container(
                        padding: const EdgeInsets.symmetric(vertical: 22),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            MainScreenButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(CalendarScreen.routeName),
              buttonText: constants.CALENDAR_SCREEN_LINK_TEXT,
            ),
            MainScreenButton(
              onPressed: () => Navigator.of(context)
                  .pushReplacementNamed(PreQuestionaryScreen.routeName),
              buttonText: constants.PREQUESTIONARY_SCREEN_LINL_TEXT,
            ),
            MainScreenButton(
              onPressed: () => Navigator.of(context)
                  .pushReplacementNamed(AddressScreen.routeName),
              buttonText: constants.ADRESS_SCREEN_LINK_TEXT,
            ),
          ],
        ),
      ),
    );
  }
}
