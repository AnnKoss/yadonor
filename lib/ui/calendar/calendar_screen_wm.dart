import 'package:flutter/material.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:intl/intl.dart';

import 'package:yadonor/data/appointment-item.dart';
import 'package:yadonor/model/calendar/repository/calendar_repository.dart';
import 'package:yadonor/model/calendar/changes.dart';
import 'package:yadonor/model/calendar/performers.dart';

enum FilterType { future, past, current }

class CalendarState {
  List<Appointment> appointments;

  DateTime from = DateTime(DateTime.now().year, DateTime.now().month, 1);

  List<Appointment> currentMonthAppointments() {
    List<Appointment> currentMonthAppointments;
    currentMonthAppointments = appointments.where(
      (entry) {
        String selectedAppointmentMonth = DateFormat.yM().format(entry.day);
        int year = from.add(Duration(days: 15)).year;
        int month = from.add(Duration(days: 15)).month;
        String currentMonth = DateFormat.yM().format(DateTime(year, month));

        return selectedAppointmentMonth == currentMonth;
      },
    ).toList();
    print('CalendarState currentMonthAppointments: ' +
        currentMonthAppointments.toString());
    return currentMonthAppointments;
  }

  FilterType selectedFilter = FilterType.current;
}

WidgetModel buildCalendarWM(BuildContext context) {
  return CalendarWidgetModel(
    WidgetModelDependencies(),
    Model([
      GetAppointmentsPerformer(
          AppointmentsRepository.globalAppointmentsRepository),
      AddAppointmentPerformer(
          AppointmentsRepository.globalAppointmentsRepository),
      RemoveAppointmentPerformer(
          AppointmentsRepository.globalAppointmentsRepository)
    ]),
  );
}

/// WidgetModel used in calendar_screen, main_screen, appointments_list_filtered
class CalendarWidgetModel extends WidgetModel {
  CalendarWidgetModel(
    WidgetModelDependencies dependencies,
    Model model,
  ) : super(
          dependencies,
          model: model,
        );

  EntityStreamedState<CalendarState> streamedState =
      EntityStreamedState(EntityState.loading());

  CalendarState state = CalendarState();

  // final isLoading = StreamedState<bool>(false);

  final Action onDaySelected = Action<DateTime>();
  final Action onAddAppointmentTap = Action<void>();
  final Action onRemoveAppointmentTap = Action<DateTime>();
  final Action onChangeVisibleDates = Action<DateTime>();
  final Action onChangeFilter = Action<FilterType>();

  @override
  onLoad() {
    super.onLoad();
    print('onLoad');
    _getAppointments();

    subscribe(
      onDaySelected.stream,
      (selectedDay) {
        _selectDay(selectedDay);
      },
    );

    subscribe(
      onAddAppointmentTap.stream,
      (_) {
        _addAppointment();
      },
    );

    subscribe(
      onRemoveAppointmentTap.stream,
      (day) {
        _removeAppointment(day);
        // streamedState.accept(EntityState.content(state));
      },
    );

    subscribe(
      onChangeVisibleDates.stream,
      (from) {
        _changeVisibleDates(from);
      },
    );

    subscribe(
      onChangeFilter.stream,
      (filter) {
        _changeFilter(filter);
      },
    );
  }

  void _getAppointments() {
    doFuture<List<Appointment>>(
      model.perform(GetAppointments()),
      (loadedAppointments) {
        state.appointments = loadedAppointments;
        this.streamedState.accept(EntityState.content(state));
      },
    );
  }

  DateTime _selectedDay = DateTime.now();

  _selectDay(DateTime day) {
    ///A handler for [onDaySelected] property of Calendar widget.
    if (day != null) {
      _selectedDay = day;
    }
    return;
  }

  void _addAppointment() {
    print('_addAppointment performed');
    doFuture<Appointment>(
      model.perform(AddAppointment(_selectedDay)),
      (Appointment addedAppointment) {
        print('addedAppointment :' + addedAppointment.day.toString());
        // state.appointments.add(addedAppointment);
        print('_addAppointment state.currentMonthAppointments:' +
            state
                .currentMonthAppointments()
                .map((e) => e.day.toString())
                .toString());
        streamedState.accept(EntityState.content(state));
      },
    );
  }

  void _removeAppointment(day) {
    doFuture(
      model.perform(RemoveAppointment(day)),
      (Appointment removedAppointment) {
        state.appointments
            .removeWhere((element) => element.day == removedAppointment.day);
        print('removed appointment: ' + removedAppointment.toString());
        state.currentMonthAppointments();
        streamedState.accept(EntityState.content(state));
        print('State after removing: ' +
            state.currentMonthAppointments().toString());
      },
    );
  }

  void _changeVisibleDates(from) {
    state.from = from;
    print('changeVisibleDaysStream');
    streamedState.accept(EntityState.content(state));
  }

  void _changeFilter(filter) {
    state.selectedFilter = filter;
    if (filter == FilterType.current) {
      state.from = DateTime(DateTime.now().year, DateTime.now().month, 1);
    }
    streamedState.accept(EntityState.content(state));
  }
}
