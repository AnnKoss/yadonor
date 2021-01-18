import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:yadonor/model/calendar/repository/calendar_repository.dart';

import 'package:yadonor/ui/main_screen/main_screen.dart';
import 'package:yadonor/ui/calendar/widgets/calendar_add_screen.dart';
import 'package:yadonor/ui/calendar/calendar_screen.dart';
import 'package:yadonor/ui/precautions/precautions_screen.dart';
import 'package:yadonor/ui/questionary/questionary_result_screen.dart';
import 'package:yadonor/ui/questionary/pre_questionary_screen.dart';
import 'package:yadonor/ui/questionary/questionary_screen.dart';
import 'package:yadonor/ui/auth/auth_screen.dart';
import 'package:yadonor/ui/address/address_screen.dart';
import 'package:yadonor/model/calendar/repository/calendar_repository.dart';

// AuthWidgetModel createAuthModel(BuildContext context) =>
//     AuthWidgetModel(
//       WidgetModelDependencies(),
//       Injector.of<AuthComponent>(context).component.navigator,
//       Model([
//         LoginPerformer(),
//         SignUpPerformer(),
//     ]),
//       // Injector.of<AuthComponent>(context).component.scaffoldKey,
//     );

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
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // return SomethingWentWrong();
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

    AppointmentsRepository.globalAppointmentsRepository = AppointmentsRepository(AppointmentsStorage());
    //FIXME

    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ru'),
      ],
      title: 'YaDonor',
      theme: ThemeData(
        primaryColor: const Color(0xff00608a),
        accentColor: const Color(0xffe9392c),
        scaffoldBackgroundColor: const Color(0xfff9fafc),
        fontFamily: 'PTSans',
        appBarTheme: AppBarTheme(
          color: Colors.white,
          iconTheme: IconThemeData(
            color: Theme.of(context).primaryColor,
          ),
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          bodyText2: TextStyle(fontSize: 18),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Theme.of(context).accentColor,
        ),
        dividerColor: Theme.of(context).primaryColor,
      ),
      home: (user != null) ? MainScreen() : AuthScreen(),
      routes: {
        MainScreen.routeName: (ctx) => MainScreen(),
        AuthScreen.routeName: (ctx) => AuthScreen(),
        PreQuestionaryScreen.routeName: (ctx) => PreQuestionaryScreen(),
        QuestionaryScreen.routeName: (ctx) => QuestionaryScreen(),
        QuestionaryResultScreen.routeName: (ctx) => QuestionaryResultScreen(),
        PrecautionsScreen.routeName: (ctx) => PrecautionsScreen(),
        CalendarScreen.routeName: (ctx) => CalendarScreen(),
        AddressScreen.routeName: (ctx) => AddressScreen(),
        CalendarAddScreen.routeName: (ctx) => CalendarAddScreen(),
      },
    );
  }
}
