// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'custom_calendar_cubit.dart';

@immutable
sealed class CustomCalendarState {
  final DateTime date;

  const CustomCalendarState({required this.date});
}

final class CustomCalendarInitial extends CustomCalendarState {
  const CustomCalendarInitial({required super.date});
}

class PickedDate extends CustomCalendarState {
  const PickedDate({required super.date});
}

class PickedMonth extends CustomCalendarState {
  const PickedMonth({required super.date});
}
