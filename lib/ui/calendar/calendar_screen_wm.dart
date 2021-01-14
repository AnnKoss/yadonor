import 'package:flutter/material.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:intl/intl.dart';

import 'package:yadonor/domain/appointment-item.dart';
import 'package:yadonor/model/calendar/repository/calendar_repository.dart';
import 'package:yadonor/model/calendar/changes.dart';

enum FilterType { future, past, current }

/// WidgetModel for calendar_screen
class CalendarWidgetModel extends WidgetModel {
  EntityStreamedState<List<Appointment>> appointments =
      EntityStreamedState(EntityState.loading([]));

  final isLoading = StreamedState<bool>(false);

  CalendarWidgetModel(
    WidgetModelDependencies dependencies,
    // Model model,
  ) : super(
          dependencies,
          // model: model,
        );

  Action onAddAppointmentTap = Action<void>();
  Action onRemoveAppointmentTap = Action<void>();

  @override
  onLoad() {
    super.onLoad();

    _getAppointments();

    subscribe(
      onAddAppointmentTap.stream,
      (_) {
        // isLoading.accept(!isLoading.value);
        _addAppointment();
        // isLoading.accept(!isLoading.value);
      },
    );
  }

  void _getAppointments() {
    doFuture<List<Appointment>>(
      model.perform(GetAppointments()),
      (appointments) {
        this.appointments.content(appointments);
      },
    );
  }

  void _addAppointment() {
    doFuture(model.perform(AddAppointment(selectedDay)), (t) => null);
  }

  Appointment get nearestAppointment {
    Appointment nearestAppointment;
    doFuture(
      model.perform(GetAppointments()),
      (appointments) {
        appointments.firstWhere((entry) {
          nearestAppointment = entry.day.isAfter(DateTime.now());
        }, orElse: nearestAppointment = null);
      },
    );
    return nearestAppointment;
  }

  /// Appointments of current month.
  List<Appointment>   getCurrentMonthAppointments() {
    List<Appointment> currentMonthAppointments;
    doFuture(
      model.perform(GetAppointments()),
      (appointments) {
        currentMonthAppointments = appointments.where(
          (entry) {
            String selectedAppointmentMonth = DateFormat.yM().format(entry.day);
            int year = firstVisibleDate.add(Duration(days: 15)).year;
            int month = firstVisibleDate.add(Duration(days: 15)).month;
            String currentMonth = DateFormat.yM().format(DateTime(year, month));

            return selectedAppointmentMonth == currentMonth;
          },
        ).toList();
      },
    );
    return currentMonthAppointments;
  }

  List<Appointment> get futureAppointments {
    List<Appointment> futureAppointments;
    doFuture(
      model.perform(GetAppointments()),
      (appointments) {
        futureAppointments = appointments.where(
        (entry) {
          return entry.day.isAfter(DateTime.now());
        },
      ).toList();
      },
    );
    return futureAppointments;
  }

  List<Appointment> get pastAppointments {
    List<Appointment> pastAppointments;
    doFuture(
      model.perform(GetAppointments()),
      (appointments) {
        pastAppointments = appointments.where(
        (entry) {
          return entry.day.isBefore(DateTime.now());
        },
      ).toList();
      },
    );
    return pastAppointments;
  }



  DateTime selectedDay = DateTime.now();

  void selectDay(DateTime day, List<Appointment> appointments) {
    ///A handler for [onDaySelected] property of Calendar widget.
    if (day != null) {
      selectedDay = day;
    }
    selectedDayCheck(day);
    return;
  }

  DateTime firstVisibleDate = DateTime(

      /// The first date visible on the screen of current month. Used for changing displayed current month appointments in appointment_list_filtered.dart.
      DateTime.now().year,
      DateTime.now().month,
      1);

  FilterType appointmentsFilter = FilterType.current;

  // List<Map<FilterType, String>> popupMenu = [
  //   {FilterType.future: 'Предстоящие донации'},
  //   {FilterType.past: 'Прошедшие донации'},
  //   {FilterType.current: 'Показать календарь'},
  // ];

  ///is the [selectedDay] in the future (true) or in the past
  bool isFutureDate = true;

  void selectedDayCheck(DateTime day) {
    ///Checks if [selectedDay] is in the past or in the future.
    if (day.isAfter(DateTime.now().subtract(Duration(days: 1)))) {
      isFutureDate = true;
    } else {
      isFutureDate = false;
    }
  }

  void changeVisibleDates(DateTime from) {
    ///Changes displayed current month appointments in appointment_list_filtered.dart.
    print('changeVisibleDates from: ' + from.toString());
    firstVisibleDate = from;

    getCurrentMonthAppointments();
  }

  void selectFilter(FilterType result) {
    appointmentsFilter = result;
    print(appointmentsFilter);
    if (appointmentsFilter == FilterType.current) {
      changeVisibleDates(
          DateTime(DateTime.now().year, DateTime.now().month, 1));
    }
  }
}
