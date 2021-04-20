import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

import 'package:yadonor/ui/calendar/calendar_screen_wm.dart';
import 'package:yadonor/ui/calendar/widgets/calendar_screen_filtered_appointments.dart';
import 'package:yadonor/ui/calendar/widgets/calendar_widget.dart';
import 'package:yadonor/ui/common/main_drawer.dart';
import 'package:yadonor/utils/constants.dart' as constants;

///Chooses whether to show events of the current month, all the future or all the past ones.

class CalendarScreen extends CoreMwwmWidget {
  CalendarScreen()
      : super(
          widgetModelBuilder: (context) => buildCalendarWM(context),
        );

  @override
  State<StatefulWidget> createState() => _CalendarScreenState();

  static const routeName = '/calendar';
}

class _CalendarScreenState extends WidgetState<CalendarWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            constants.CALENDAR_SCREEN_TITLE,
            // style: Theme.of(context).appBarTheme.textTheme.headline1,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            PopupMenuButton<FilterType>(
              onSelected: wm.onChangeFilter,
              itemBuilder: (context) => 
              <PopupMenuEntry<FilterType>>[
                PopupMenuItem<FilterType>(
                  value: FilterType.future,
                  child: Text(constants.CALENDAR_FILTER_FUTURE_TEXT),
                ),
                PopupMenuDivider(),
                PopupMenuItem<FilterType>(
                  value: FilterType.past,
                  child: Text(constants.CALENDAR_FILTER_PAST_TEXT),
                ),
                PopupMenuDivider(),
                PopupMenuItem<FilterType>(
                  value: FilterType.current,
                  child: Text(constants.CALENDAR_FILTER_CURRENT_TEXT),
                ),
              ],
            ),
          ],
        ),
        drawer: MainDrawer(),
        body: EntityStateBuilder<CalendarState>(
          streamedState: wm.streamedState,
          child: (context, state) {
            return Column(children: <Widget>[
              (state.selectedFilter == FilterType.current)
                  ? Card(
                      elevation: 3,
                      margin: const EdgeInsets.only(top: 10),
                      child: Calendar(
                        onDaySelected: (day, _) {
                          wm.onDaySelected(day);
                        },
                        onVisibleDaysChanged: (from, to, format) {
                          wm.onChangeVisibleDates(from);
                        },
                        appointments: state.appointments,
                      ),
                    )
                  : SizedBox(height: 0),
              Flexible(
                fit: FlexFit.loose,
                child: AppointmentListFiltered(
                  state.appointments,
                  state.currentMonthAppointments(),
                  wm.onRemoveAppointmentTap,
                  state.selectedFilter,
                ),
              ),
            ]);
          },
          loadingBuilder: (context, state) {
            return Column(
              children: <Widget>[
                (state.selectedFilter == FilterType.current)
                    ? Card(
                        elevation: 3,
                        margin: const EdgeInsets.only(top: 10),
                        child: Calendar(
                          onDaySelected: (day, _) {
                            wm.onDaySelected(day);
                          },
                          onVisibleDaysChanged: (from, to, format) {
                            wm.onChangeVisibleDates(from);
                          },
                          appointments: [],
                        ),
                      )
                    : SizedBox(height: 0),
                Flexible(
                  fit: FlexFit.loose,
                  child: Stack(
                    children: <Widget>[
                      AppointmentListFiltered(
                        state.appointments,
                        state.currentMonthAppointments(),
                        wm.onRemoveAppointmentTap,
                        state.selectedFilter,
                      ),
                      Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Color(0xffffff).withOpacity(0.3)),
                      Center(child: CircularProgressIndicator()),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            wm.onAddAppointmentTap();
            print('button pressed');
          },
          backgroundColor: Theme.of(context).accentColor,
          elevation: 5,
          child: Icon(Icons.add),
        ));
  }
}
