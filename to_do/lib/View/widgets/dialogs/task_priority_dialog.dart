import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Model/constants/enums.dart';
import 'package:to_do/Model_View/cubit/priority/priority_cubit.dart';
import 'package:to_do/View/theme/theme.dart';
import 'package:to_do/View/widgets/visual_utils/buttons.dart';
import 'package:to_do/general_utils/screen_size_helper.dart';
import 'package:to_do/View/widgets/visual_utils/themed_text.dart';

class TaskPriorityDialog extends StatelessWidget {
  const TaskPriorityDialog({super.key, required this.mode});

  final TaskFieldsModes mode;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PriorityCubit(),
      child: Container(
        decoration:
            BoxDecoration(color: AppColors.instance.navigationBarBackground),
        height: ScreenSizeHelper.height_P(context, 0.53),
        width: ScreenSizeHelper.width_P(context, 0.95),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: ScreenSizeHelper.height_P(context, 0.015),
              horizontal: ScreenSizeHelper.width_P(context, 0.07)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const TitleMediumText(text: 'Task Priority'),
              SizedBox(height: ScreenSizeHelper.height_P(context, 0.03)),
              const PrioritiesBoxesGrid(),
              const Spacer(),
              PriorityButtons(mode: mode)
            ],
          ),
        ),
      ),
    );
  }
}

class PrioritiesBoxesGrid extends StatelessWidget {
  const PrioritiesBoxesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenSizeHelper.height_P(context, 0.35),
      child: GridView.builder(
        itemCount: 10,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 8, mainAxisSpacing: 25, crossAxisCount: 4),
        itemBuilder: (context, index) {
          return TaskPriorityBox(priority: index + 1);
        },
      ),
    );
  }
}

class PriorityButtons extends StatelessWidget {
  const PriorityButtons({super.key, required this.mode});
  final TaskFieldsModes mode;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CancelButton(),
        const Spacer(),
        SavePriorityButton(mode: mode)
      ],
    );
  }
}
