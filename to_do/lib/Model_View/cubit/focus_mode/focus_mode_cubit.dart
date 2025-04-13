import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'focus_mode_state.dart';

class FocusModeCubit extends Cubit<FocusModeState> {
  FocusModeCubit() : super(const FocusModeInitial());

  Stopwatch stopwatch = Stopwatch();
  Timer? timer;
  Duration duration = const Duration(minutes: 30);

  void startFocusing() {
    stopwatch.reset();
    stopwatch.start();
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        var time = _formatDuration(stopwatch.elapsed);
        var elapsed = _calculateElapsed(duration, stopwatch.elapsed);
        emit(Focusing(time: time, elapsed: elapsed));
      },
    );
  }

  void stopFocusing() {
    _stopStopWatch();
    _stopTimer();
    var time = _formatDuration(stopwatch.elapsed);
    var elapsed = _calculateElapsed(duration, stopwatch.elapsed);
    emit(StoppedFocusing(time: time, elapsed: elapsed));
  }

  void _stopTimer() {
    timer?.cancel();
  }

  void _stopStopWatch() {
    stopwatch.stop();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return "$minutes:$seconds";
  }

  double _calculateElapsed(Duration constDuration, localDuration) {
    double elapsed = localDuration.inSeconds / constDuration.inSeconds;
    return elapsed - elapsed.floor();
  }
}
