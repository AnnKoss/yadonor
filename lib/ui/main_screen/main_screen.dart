import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

import 'package:yadonor/ui/calendar/calendar_screen.dart';
import 'package:yadonor/ui/questionary/pre_questionary_screen.dart';
import 'package:yadonor/ui/address/address_screen.dart';
import 'package:yadonor/ui/main_screen/main_screen_button.dart';
import 'package:yadonor/ui/common/main_drawer.dart';
import 'package:yadonor/ui/common/appointment_card.dart';
import 'package:yadonor/ui/calendar/calendar_screen_wm.dart';

class MainScreen extends CoreMwwmWidget {
  MainScreen()
      : super(
          widgetModelBuilder: (context) =>
              CalendarWidgetModel.buildCalendarWM(context),
        );

  @override
  State<StatefulWidget> createState() => _MainScreenState();

  static const routeName = '/main';
}

class _MainScreenState extends WidgetState<CalendarWidgetModel> {
  @override
  Widget build(BuildContext context) {
    print('build mainScreen');
    print(FirebaseAuth.instance.currentUser);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'DONOR APP',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      drawer: MainDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [const Color(0xff00d4ff), const Color(0xff00608a)],
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 10),
                elevation: 3,
                child: StreamedStateBuilder<bool>(
                  streamedState: wm.isLoading,
                  builder: (context, isLoading) {
                    return Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Ближайшая донация:',
                            textAlign: TextAlign.center,
                          ),
                          padding: EdgeInsets.only(top: 10),
                          width: double.infinity,
                        ),
                        (isLoading)
                            ? Container(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: CircularProgressIndicator(),
                              )
                            : Container(
                                child: (wm.nearestAppointment != null)
                                    ? Container(
                                        margin: EdgeInsets.all(10),
                                        child: AppointmentCard(
                                          appointment: wm.nearestAppointment,
                                          hasCloseIcon: false,
                                        ),
                                      )
                                    : FlatButton(
                                        onPressed: () => Navigator.of(context)
                                            .pushNamed(
                                                CalendarScreen.routeName),
                                        child: Text('Запланировать',
                                            style: TextStyle(fontSize: 20)),
                                        textColor:
                                            Theme.of(context).accentColor,
                                      ),
                              ),
                      ],
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            mainScreenButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(CalendarScreen.routeName),
              buttonText: 'КАЛЕНДАРЬ',
            ),
            mainScreenButton(
              onPressed: () => Navigator.of(context)
                  .pushReplacementNamed(PreQuestionaryScreen.routeName),
              buttonText: 'ПОДГОТОВКА К ДОНАЦИИ',
            ),
            mainScreenButton(
              onPressed: () => Navigator.of(context)
                  .pushReplacementNamed(AddressScreen.routeName),
              buttonText: 'АДРЕСА',
            ),
          ],
        ),
      ),
    );
  }
}
