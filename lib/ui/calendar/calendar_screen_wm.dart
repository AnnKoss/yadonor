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
        // streamedState.loading();
        print('onAddAppointmentTap loading: ' + streamedState.toString());

        _addAppointment();
        // streamedState.accept(EntityState.content(state));
      },
    );

    subscribe(
      onRemoveAppointmentTap.stream,
      (day) {
        streamedState.loading();
        print('currentMonthAppointments before removing: ' +
            state.currentMonthAppointments().toString());
        _removeAppointment(day);
        streamedState.accept(EntityState.content(state));
        print('currentMonthAppointments after removing: ' +
            state.currentMonthAppointments().toString());
      },
    );

    subscribe(
      onChangeVisibleDates.stream,
      (from) {
        state.from = from;
        print('changeVisibleDaysStream');
        streamedState.accept(EntityState.content(state));
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

  _selectDay(DateTime day) {
    ///A handler for [onDaySelected] property of Calendar widget.
    if (day != null) {
      _selectedDay = day;
    }
    selectedDayCheck(day);
    return;
  }

  void _addAppointment() {
    doFuture<Appointment>(
      model.perform(AddAppointment(_selectedDay)),
      (Appointment addedAppointment) {
        print('addedAppointment :' + addedAppointment.day.toString());
        state.appointments.add(addedAppointment);
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
        print('State after removing: ' + state.currentMonthAppointments().toString());
      },
    );
  }

  DateTime _selectedDay = DateTime.now();

  FilterType appointmentsFilter = FilterType.current;

  // List<Map<FilterType, String>> popupMenu = [
  //   {FilterType.future: 'Предстоящие донации'},
  //   {FilterType.past: 'Прошедшие донации'},
  //   {FilterType.current: 'Показать календарь'},
  // ];

  ///is the [_selectedDay] in the future (true) or in the past
  bool isFutureDate = true;

  void selectedDayCheck(DateTime day) {
    ///Checks if [selectedDay] is in the past or in the future.
    if (day.isAfter(DateTime.now().subtract(Duration(days: 1)))) {
      isFutureDate = true;
    } else {
      isFutureDate = false;
    }
  }

  void selectFilter(FilterType result) {
    appointmentsFilter = result;
    print(appointmentsFilter);
    if (appointmentsFilter == FilterType.current) {
      state.from = DateTime(DateTime.now().year, DateTime.now().month, 1);
    }
  }
}
