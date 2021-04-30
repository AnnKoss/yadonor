import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:yadonor/data/calendar/appointments_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yadonor/ui/calendar_screen/appointments_bloc.dart';
import 'package:yadonor/ui/common/defauld_alert_dialog.dart';
import 'package:yadonor/ui/main_screen/main_screen.dart';
import 'package:yadonor/ui/calendar_screen/calendar_screen.dart';
import 'package:yadonor/ui/questionary_screen/questionary_result_screen.dart';
import 'package:yadonor/ui/questionary_screen/pre_questionary_screen.dart';
import 'package:yadonor/ui/questionary_screen/questionary_screen.dart';
import 'package:yadonor/ui/auth_screen/auth_screen.dart';
import 'package:yadonor/ui/common/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        name: 'yadonor-app',
        options: FirebaseOptions(
            apiKey: 'AIzaSyBFJnPsYK5SwBriEXhg9vcYdFr8X4CB86E',
            appId: '1:893719550415:android:25e690f9d65696c1f21aba',
            messagingSenderId: '893719550415',
            projectId: 'yadonor-app'),
      ),
      builder: (
        context,
        snapshot,
      ) {
        if (snapshot.hasError) {
          return DefaultAlertDialog();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return DonorApp();
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class DonorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = _auth.currentUser;

    return Provider<AppointmentsRepository>(
      create: (ctx) => AppointmentsRepository(AppointmentsStorage()),
      child: BlocProvider<AppointmentsBloc>(
        create: (BuildContext context) {
          AppointmentsBloc _bloc = AppointmentsBloc(
            AppointmentsLoadingState(),
            context.read<AppointmentsRepository>(),
          );
          return _bloc;
        },
        child: MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('ru'),
          ],
          title: 'YaDonor',
          theme: themeData(context),
          home: (user != null) ? MainScreen() : AuthScreen(),
          routes: {
            MainScreen.routeName: (ctx) => MainScreen(),
            AuthScreen.routeName: (ctx) => AuthScreen(),
            PreQuestionaryScreen.routeName: (ctx) => PreQuestionaryScreen(),
            QuestionaryScreen.routeName: (ctx) => QuestionaryScreen(),
            QuestionaryResultScreen.routeName: (ctx) =>
                QuestionaryResultScreen(),
            CalendarScreen.routeName: (ctx) => CalendarScreen(),
          },
        ),
      ),
    );
  }
}
