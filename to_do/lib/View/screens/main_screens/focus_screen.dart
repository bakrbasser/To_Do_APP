import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Model_View/cubit/focus_mode/focus_mode_cubit.dart';
import 'package:to_do/View/theme/theme.dart';
import 'package:to_do/View/widgets/visual_utils/buttons.dart';
import 'package:to_do/View/widgets/visual_utils/themed_text.dart';
import 'package:to_do/general_utils/screen_size_helper.dart';

class FocusScreen extends StatelessWidget {
  const FocusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BodyLargeText(text: 'Focus'),
      ),
      body: Column(
        children: [
          BlocBuilder<FocusModeCubit, FocusModeState>(
            builder: (context, state) {
              return TimerCircularProgress(
                elapsed: state.elapsed,
                time: state.time,
              );
            },
          ),
          const SizedBox(height: 50),
          const StartStopFocusingButton()
        ],
      ),
    );
  }
}

class TimerCircularProgress extends StatelessWidget {
  const TimerCircularProgress(
      {super.key, required this.elapsed, required this.time});

  final double elapsed;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: ScreenSizeHelper.width_P(context, 0.6),
              width: ScreenSizeHelper.width_P(context, 0.6),
              child: CircularProgressIndicator(
                backgroundColor: AppColors.instance.neutralGray,
                color: AppColors.instance.appPurple,
                strokeWidth: 18,
                value: elapsed,
              ),
            ),
            TitleLargeText(text: time),
          ],
        ),
      ),
    );
  }
}
