import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:yadonor/data/providers/calendar_appointments_provider.dart';
import 'package:yadonor/data/calendar_screen_view.dart';
import 'package:yadonor/ui/questionary/pre_questionary_screen.dart';
import 'package:yadonor/ui/address/address_screen.dart';
import 'package:yadonor/ui/main_screen_button.dart';
import 'package:yadonor/ui/main_drawer.dart';
import 'package:yadonor/ui/appointment_card.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
                child: Consumer<CalendarAppointmentsProvider>(
                  builder: (context, calendarAppointmentsData, child) {
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
                        (Provider.of<CalendarAppointmentsProvider>(context)
                                .isFetchAppointmentsLoading) //зачем?
                            ? Container(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: CircularProgressIndicator(),
                              )
                            : (calendarAppointmentsData
                                        .getNearestAppointment() != // а если future?
                                    null)
                                ? Container(
                                    margin: EdgeInsets.all(10),
                                    child: AppointmentCard(
                                      appointment: calendarAppointmentsData
                                          .getNearestAppointment(),
                                      hasCloseIcon: false,
                                    ),
                                  )
                                : FlatButton(
                                    onPressed: () => Navigator.of(context)
                                        .pushNamed(
                                            CalendarScreenView.routeName),
                                    child: Text('Запланировать',
                                        style: TextStyle(fontSize: 20)),
                                    textColor: Theme.of(context).accentColor,
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
                  Navigator.of(context).pushNamed(CalendarScreenView.routeName),
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
