import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:yadonor/ui/calendar/appointments_bloc.dart';
import 'package:yadonor/ui/calendar/calendar_screen.dart';
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
  void initState() {
    super.initState();

    context.read<AppointmentsBloc>().add(GetAppointmentsEvent());
  }

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

                //todo: У тебя встать блок, который будет работать с репозиторием
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Ближайшая донация:',
                        textAlign: TextAlign.center,
                      ),
                      margin: EdgeInsets.only(top: 10),
                      width: double.infinity,
                    ),
                    Container(
                      height: 75,
                      margin: EdgeInsets.only(bottom: 10),
                      child: BlocBuilder<AppointmentsBloc, AppointmentsState>(
                          builder: (context, state) {
                        print(
                            'main_screen incoming state: ' + state.toString());
                        if (state is AppointmentsLoadingState) {
                          return Container(
                            margin: EdgeInsets.all(10),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        if (state is AppointmentsLoadedState) {
                          print('main_screen appointmentsList: ');
                          print(state.appointmentsList.appointments);
                          print('nearestAppointment: ');
                          print(state.appointmentsList.nearestAppointment);
                          return (state.appointmentsList.nearestAppointment !=
                                  null)
                              ? Container(
                                  margin: EdgeInsets.all(10),
                                  width: 300,
                                  child: AppointmentCard(
                                    appointment: state
                                        .appointmentsList.nearestAppointment,
                                    hasCloseIcon: false,
                                  ),
                                )
                              : FlatButton(
                                  onPressed: () => Navigator.of(context)
                                      .pushNamed(CalendarScreen.routeName),
                                  child: Text('Запланировать',
                                      style: TextStyle(fontSize: 20)),
                                  textColor: Theme.of(context).accentColor,
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                );
                        }
                        return const Text('Something went wrong!');
                      }),
                    )
                  ],
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
