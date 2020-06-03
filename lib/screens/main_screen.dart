import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/calendar_events_provider.dart';

import './calendar_screen.dart';
import './pre_questionary_screen.dart';
import '../widgets/button.dart';
import '../widgets/main_drawer.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    // final calendarData = Provider.of<CalendarProvider>(context);
    // List futureEvents = calendarData.futureEvents;
    // print(futureEvents[0]);

    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        title: Text(
          'DONOR APP',
          style: Theme.of(context).textTheme.title,
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
                child: Consumer<CalendarEventsProvider>(
                  builder: (context, calendarData, child) {
                    return Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Ближайшая запланированная донация:',
                            textAlign: TextAlign.center,
                          ),
                          padding: EdgeInsets.only(top: 10),
                          width: double.infinity,
                        ),
                        (calendarData.futureEvents.length > 0)
                            ? Container(
                                width: 300,
                                margin: EdgeInsets.all(10),
                                // color: Colors.amber,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).accentColor,
                                    radius: 20,
                                    child:
                                        // Icon(
                                        // Icons.event_available,
                                        // size: 30,
                                        // color: Colors.white,
                                        Image(
                                      image: AssetImage(
                                          'assets/images/blood_drop.png'),
                                      height: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                  title: Text(DateFormat('d MMMM y, EEEE', 'ru')
                                      .format(
                                          calendarData.futureEvents[0].day)),
                                  subtitle: Text(calendarData
                                      .futureEvents[0].event[0]
                                      .toString()),
                                ),
                              )
                            : FlatButton(
                                onPressed: () => Navigator.of(context)
                                    .pushNamed(CalendarScreen.routeName),
                                child: Text('Запланировать',
                                    style: TextStyle(fontSize: 20)),
                                textColor: Theme.of(context).accentColor,
                              ),
                      ],
                    );
                  },
                ),
              ),
              // Text(
              //   (futureEvents.length > 0) ? 'Yep' : 'None',
              // ),
            ),
            SizedBox(height: 50),
            // FlatButton(
            //   onPressed: () =>
            //       Navigator.of(context).pushNamed(CalendarScreen.routeName),
            //   child: Text('КАЛЕНДАРЬ', style: TextStyle(fontSize: 26)),
            //   textColor: Theme.of(context).primaryColor,
            //   // color: Colors.white,
            // ),
            // FlatButton(
            //   onPressed: () => Navigator.of(context)
            //       .pushNamed(PreQuestionaryScreen.routeName),
            //   child:
            //       Text('ПОДГОТОВКА К ДОНАЦИИ', style: TextStyle(fontSize: 26)),
            //   textColor: Theme.of(context).primaryColor,
            // ),
            // FlatButton(
            //   onPressed: () {},
            //   child: Text('АДРЕСА', style: TextStyle(fontSize: 26)),
            //   textColor: Theme.of(context).primaryColor,
            // ),
            button(
              context: context,
              onPressed: () =>
                  Navigator.of(context).pushNamed(CalendarScreen.routeName),
              buttonText: 'КАЛЕНДАРЬ',
            ),
            button(
              context: context,
              onPressed: () => Navigator.of(context)
                  .pushReplacementNamed(PreQuestionaryScreen.routeName),
              buttonText: 'ПОДГОТОВКА К ДОНАЦИИ',
            ),
            button(
              context: context,
              onPressed: () {},
              buttonText: 'АДРЕСА',
            ),
          ],
        ),
      ),
    );
  }
}
