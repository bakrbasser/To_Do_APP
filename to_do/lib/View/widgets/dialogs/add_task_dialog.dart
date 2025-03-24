import 'package:flutter/material.dart';
import 'package:to_do/View/theme/theme.dart';
import 'package:to_do/View/widgets/visual_utils/buttons.dart';
import 'package:to_do/general_utils/screen_size_helper.dart';
import 'package:to_do/View/widgets/visual_utils/text_fields.dart';
import 'package:to_do/View/widgets/visual_utils/themed_text.dart';

class AddTaskDialog extends StatelessWidget {
  const AddTaskDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: AppColors.instance.navigationBarBackground),
      height: ScreenSizeHelper.height_P(context, 0.35),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenSizeHelper.width_P(context, 0.07)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TitleMediumText(text: 'Add Task'),
            SizedBox(height: ScreenSizeHelper.height_P(context, 0.03)),
            TaskTitle(),
            SizedBox(height: ScreenSizeHelper.height_P(context, 0.03)),
            TaskDescription(),
            SizedBox(height: ScreenSizeHelper.height_P(context, 0.03)),
            const AddingTaskProperties()
          ],
        ),
      ),
    );
  }
}

class AddingTaskProperties extends StatelessWidget {
  const AddingTaskProperties({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const PickTaskDateButton(),
        SizedBox(
          width: ScreenSizeHelper.width_P(context, 0.05),
        ),
        const PickTaskCategory(),
        SizedBox(
          width: ScreenSizeHelper.width_P(context, 0.05),
        ),
        const PickTaskPriority(),
        const Spacer(),
        const AddTaskButton()
      ],
    );
  }
}
