import 'package:flutter/material.dart';
import 'package:to_do/Model/models/task_model.dart';
import 'package:to_do/Model_View/storage/cached_task.dart';
import 'package:to_do/View/widgets/specified_function_widgets/task_widgets.dart';
import 'package:to_do/View/widgets/visual_utils/buttons.dart';
import 'package:to_do/general_utils/screen_size_helper.dart';
import 'package:to_do/View/widgets/visual_utils/themed_text.dart';

class TaskDetails extends StatefulWidget {
  const TaskDetails({super.key, required this.task});
  final TaskModel task;

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  @override
  void initState() {
    super.initState();
    Cached_Task_For_Updating.instance.task = widget.task;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ExitButtonInBox(),
            SizedBox(height: ScreenSizeHelper.height_P(context, 0.02)),
            CheckTitleEditRow(isDone: false, id: 0, title: widget.task.title),
            Padding(
                padding: EdgeInsets.only(
                    left: ScreenSizeHelper.width_P(context, 0.17)),
                child: BodyMediumText(text: widget.task.description!)),
            SizedBox(height: ScreenSizeHelper.height_P(context, 0.02)),
            IconWithTextAndButton(
                icon: Icons.access_time,
                text: 'Task Date:',
                button: EditTaskDate(date: widget.task.formattedDate)),
            SizedBox(height: ScreenSizeHelper.height_P(context, 0.04)),
            IconWithTextAndButton(
                icon: Icons.discount_outlined,
                text: 'Task Category:',
                button: EditTaskCategory(categoryId: widget.task.categoryId)),
            SizedBox(height: ScreenSizeHelper.height_P(context, 0.04)),
            IconWithTextAndButton(
                icon: Icons.flag_outlined,
                text: 'Task Priority:',
                button: EditTaskPriority(priority: widget.task.priority!)),
            SizedBox(height: ScreenSizeHelper.height_P(context, 0.06)),
            DeleteTaskButton(id: widget.task.id!)
          ],
        ),
      ),
    );
  }
}

class IconWithTextAndButton extends StatelessWidget {
  const IconWithTextAndButton(
      {super.key,
      required this.icon,
      required this.text,
      required this.button});
  final IconData icon;
  final String text;
  final Widget button;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        const SizedBox(width: 20),
        BodyLargeText(text: text),
        const Spacer(),
        button
      ],
    );
  }
}
