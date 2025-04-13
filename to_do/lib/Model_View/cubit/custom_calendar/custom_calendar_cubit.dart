import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'custom_calendar_state.dart';

class CustomCalendarCubit extends Cubit<CustomCalendarState> {
  CustomCalendarCubit() : super(CustomCalendarInitial(date: DateTime.now()));

  int year = DateTime.now().year;
  int month = DateTime.now().month;
  int day = DateTime.now().day;

  pickDate(int day) {
    emit(PickedDate(date: DateTime(year, month, day)));
    this.day = day;
  }

  selectNextMonth() {
    if (month != 12) {
      month++;
    } else {
      month = 1;
      year++;
    }
    emit(PickedMonth(date: DateTime(year, month, day)));
  }

  selectPreviousMonth() {
    if (month != 1) {
      month--;
    } else {
      month = 12;
      year--;
    }
    emit(PickedMonth(date: DateTime(year, month, day)));
  }
}
