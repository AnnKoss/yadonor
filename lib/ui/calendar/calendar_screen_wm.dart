import 'package:flutter/material.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:intl/intl.dart';

import 'package:yadonor/data/appointment-item.dart';
import 'package:yadonor/model/calendar/repository/calendar_repository.dart';
import 'package:yadonor/model/calendar/changes.dart';
import 'package:yadonor/model/calendar/performers.dart';

enum FilterType { future, past, current }

/// WidgetModel used in calendar_screen, main_screen, appointments_list_filtered
class CalendarWidgetModel extends WidgetModel {
  static CalendarWidgetModel _wm;

  static WidgetModel buildCalendarWM(BuildContext context) {
    if (_wm != null) return _wm;
    _wm = CalendarWidgetModel(
      WidgetModelDependencies(),
      Model([
        GetAppointmentsPerformer(
          AppointmentsRepository.globalAppointmentsRepository,
        ),
      ]),
    );
    return _wm;
  }
  //is this bit of code legal?

  EntityStreamedState<List<Appointment>> appointments =
      EntityStreamedState(EntityState.loading([]));

  final isLoading = StreamedState<bool>(false);

  CalendarWidgetModel(
    WidgetModelDependencies dependencies,
    Model model,
  ) : super(
          dependencies,
          model: model,
        );

  Action onAddAppointmentTap = Action<void>();
  Action onRemoveAppointmentTap = Action<void>();
  Action onChangeVisibleDates = Action<void Function(DateTime from)>();

  @override
  onLoad() {
    super.onLoad();

    _getAppointments();

    subscribe(
      onAddAppointmentTap.stream,
      (_) {
        appointments.loading();
        try {
          _addAppointment();
        } catch (e) {
          appointments.error(e);
        }
      },
    );
    // is this one better than the following?

    subscribe(
      onRemoveAppointmentTap.stream,
      (_) {
        isLoading.accept(!isLoading.value);
        _removeAppointment();
        isLoading.accept(!isLoading.value);
      },
    );

    subscribe(
      onChangeVisibleDates.stream,
      (_) {
        DateTime from = onChangeVisibleDates.value;
        // what should be here?
        isLoading.accept(!isLoading.value);
        changeVisibleDates(from);
        // how to get arguments from UI?
        isLoading.accept(!isLoading.value);
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

  void _removeAppointment() {
    doFuture(model.perform(RemoveAppointment(selectedDay)), (t) => null);
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

  List<Appointment> currentMonthAppointments = [];

  /// Appointments of current month.
  // List<Appointment>
  void getCurrentMonthAppointments() {
    // List<Appointment> currentMonthAppointments = [];
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
        print('getCurrentMonthAppointments() appointments: ' +
            appointments.toString());
      },
    );
    // print('getCurrentMonthAppointments(): ' +
    //     currentMonthAppointments.toString());
    // return currentMonthAppointments;
  }

  List<Appointment> getFutureAppointments() {
    List<Appointment> futureAppointments = [];
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

  List<Appointment> getPastAppointments() {
    List<Appointment> pastAppointments = [];
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
