part of 'focus_mode_cubit.dart';

@immutable
sealed class FocusModeState {
  final String time;
  final double elapsed;

  const FocusModeState({required this.time, required this.elapsed});
}

final class FocusModeInitial extends FocusModeState {
  const FocusModeInitial({super.time = '00:00', super.elapsed = 0});
}

class Focusing extends FocusModeState {
  const Focusing({required super.time, required super.elapsed});
}

class StoppedFocusing extends FocusModeState {
  const StoppedFocusing({required super.time, required super.elapsed});
}
