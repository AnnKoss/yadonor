import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './providers/calendar_provider.dart';

import './screens/calendar_add_screen.dart';
import './screens/calendar_screen.dart';
import './screens/precautions_screen.dart';
// import './screens/success_result_screen.dart';
import './screens/questionary_result_screen.dart';
import './screens/pre_questionary_screen.dart';
import './screens/questionary_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => CalendarProvider(),
      child: MaterialApp(
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
              color: const Color(0xff00608a),
            ),
          ),
          textTheme: TextTheme(
            title: TextStyle(
              color: const Color(0xff00608a),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            subhead: TextStyle(
              fontSize: 21,
              // height: 3,
            ),
            body1: TextStyle(fontSize: 18),
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: Theme.of(context).accentColor,
          ),
          dividerColor: Theme.of(context).primaryColor,
        ),
        home: CalendarScreen(),
        routes: {
          PreQuestionaryScreen.routeName: (ctx) => PreQuestionaryScreen(),
          QuestionaryScreen.routeName: (ctx) => QuestionaryScreen(),
          QuestionaryResultScreen.routeName: (ctx) => QuestionaryResultScreen(),
          PrecautionsScreen.routeName: (ctx) => PrecautionsScreen(),
          CalendarScreen.routeName: (ctx) => CalendarScreen(),
          CalendarAddScreen.routeName: (ctx) => CalendarAddScreen(),
          // SuccessResult.routeName: (ctx) => SuccessResult(),
        },
      ),
    );
  }
}
