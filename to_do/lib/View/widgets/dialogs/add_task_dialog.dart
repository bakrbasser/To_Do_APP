import 'package:flutter/material.dart';
import 'package:to_do/View/theme/theme.dart';
import 'package:to_do/View/visual_utils/screen_size_helper.dart';
import 'package:to_do/View/visual_utils/text_fields.dart';
import 'package:to_do/View/visual_utils/themed_text.dart';
import 'package:to_do/View/widgets/adding_task_properties.dart';

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
