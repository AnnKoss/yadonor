import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:yadonor/ui/calendar_screen/appointments_bloc.dart';
import 'package:yadonor/ui/calendar_screen/calendar_screen.dart';
import 'package:yadonor/ui/common/appBar.dart';
import 'package:yadonor/ui/common/defauld_alert_dialog.dart';
import 'package:yadonor/ui/questionary_screen/pre_questionary_screen.dart';
import 'package:yadonor/ui/main_screen/widgets/main_screen_button.dart';
import 'package:yadonor/ui/common/main_drawer.dart';
import 'package:yadonor/ui/common/appointment_card.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();

    context.read<AppointmentsBloc>().add(
          GetAppointmentsEvent(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: AppBarTitile(
          'donor app',
        ),
      ),
      drawer: MainDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xff00d4ff),
              const Color(0xff00608a),
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                elevation: 3,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Ближайшая донация:',
                        textAlign: TextAlign.center,
                      ),
                      margin: const EdgeInsets.only(top: 10),
                      width: double.infinity,
                    ),
                    Container(
                      height: 75,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: BlocBuilder<AppointmentsBloc, AppointmentsState>(
                          builder: (
                        context,
                        state,
                      ) {
                        if (state is AppointmentsLoadingState) {
                          return Container(
                            margin: const EdgeInsets.all(10),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        if (state is AppointmentsLoadedState) {
                          return (state.appointments.nearestAppointment != null)
                              ? Container(
                                  margin: const EdgeInsets.all(10),
                                  width: 250,
                                  child: AppointmentCard(
                                    appointment:
                                        state.appointments.nearestAppointment,
                                    hasCloseIcon: false,
                                  ),
                                )
                              : FlatButton(
                                  onPressed: () => Navigator.of(context)
                                      .pushNamed(CalendarScreen.routeName),
                                  child: Text(
                                    'Запланировать',
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  textColor: Theme.of(context).accentColor,
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                );
                        }
                        return DefaultAlertDialog();
                      }),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            MainScreenButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(CalendarScreen.routeName),
              buttonText: 'КАЛЕНДАРЬ ДОНОРА',
            ),
            MainScreenButton(
              onPressed: () => Navigator.of(context)
                  .pushReplacementNamed(PreQuestionaryScreen.routeName),
              buttonText: 'ПОДГОТОВКА К ДОНАЦИИ',
            ),
          ],
        ),
      ),
    );
  }
}
