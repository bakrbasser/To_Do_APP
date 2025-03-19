import 'package:flutter/material.dart';
import 'package:to_do/Model/models/category_model.dart';
import 'package:to_do/Model/models/task_model.dart';
import 'package:to_do/View/theme/theme.dart';
import 'package:to_do/View/visual_utils/screen_size_helper.dart';
import 'package:to_do/View/visual_utils/themed_text.dart';

//Task Card Related Widgets

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenSizeHelper.height_P(context, 0.1),
      child: Container(
        color: AppColors.instance.navigationBarBackground,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TaskCheckBox(isDone: task.isDoneAsBool),
            TitleAndDate(title: task.title, date: task.formattedDate),
            CategoryAndPriority(
                category: CategoryModel(
                    id: 1, name: 'University', color: '0xff8687E7'),
                priority: task.priority!)
          ],
        ),
      ),
    );
  }
}

class TaskCheckBox extends StatefulWidget {
  const TaskCheckBox({super.key, required this.isDone});
  final bool isDone;
  @override
  State<TaskCheckBox> createState() => _TaskCheckBoxState();
}

class _TaskCheckBoxState extends State<TaskCheckBox> {
  late bool isChecked = widget.isDone;

  void onChanged(bool? value) {
    // TODO: Handle task completion
    setState(() {
      isChecked = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      onChanged: (value) {
        onChanged(value);
      },
    );
  }
}

class TitleAndDate extends StatelessWidget {
  const TitleAndDate({super.key, required this.title, required this.date});
  final String title;
  final String date;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BodyLargeText(text: title),
        BodyMediumText(
          text: date,
          color: AppColors.instance.lessWhite,
        )
      ],
    );
  }
}

class CategoryAndPriority extends StatelessWidget {
  const CategoryAndPriority(
      {super.key, required this.category, required this.priority});
  final CategoryModel category;
  final int priority;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Row(
          children: [
            CategoryBadge(category: category),
            const SizedBox(width: 10),
            PriorityBadge(priority: priority),
          ],
        ),
      ],
    );
  }
}

class CategoryBadge extends StatelessWidget {
  const CategoryBadge({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenSizeHelper.height_P(context, 0.05),
      child: Card(
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(3)),
        color: Color(int.parse(category.color)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BodyMediumText(text: category.name),
        ),
      ),
    );
  }
}

class PriorityBadge extends StatelessWidget {
  const PriorityBadge({super.key, required this.priority});
  final int priority;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenSizeHelper.height_P(context, 0.05),
      child: Card(
        color: Colors.transparent,
        shape: BeveledRectangleBorder(
            side: BorderSide(color: AppColors.instance.appPurple),
            borderRadius: BorderRadius.circular(3)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(
                Icons.flag_outlined,
                color: Colors.white,
              ),
              BodyMediumText(text: priority.toString())
            ],
          ),
        ),
      ),
    );
  }
}

// Task List Related Widgets

class TasksList extends StatelessWidget {
  const TasksList({super.key, required this.tasks});
  final List<TaskModel> tasks;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) => TaskCard(
        task: tasks[index],
      ),
    );
  }
}
