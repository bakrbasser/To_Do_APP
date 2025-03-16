part of 'priority_cubit.dart';

@immutable
sealed class PriorityState {}

final class PriorityInitial extends PriorityState {}

class SelectedPriority extends PriorityState {
  final int priority;

  SelectedPriority({required this.priority});
}
