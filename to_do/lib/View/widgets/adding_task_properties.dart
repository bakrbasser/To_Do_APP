import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Model_View/cubit/task/task_crud/task_cubit.dart';
import 'package:to_do/View/visual_utils/buttons.dart';
import 'package:to_do/View/visual_utils/screen_size_helper.dart';

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
