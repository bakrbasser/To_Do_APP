import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Model/models/category_model.dart';
import 'package:to_do/Model/models/task_model.dart';
import 'package:to_do/Model_View/cubit/task/task_crud/task_cubit.dart';
import 'package:to_do/Model_View/storage/cached_task.dart';
import 'package:to_do/Model_View/storage/in_memory_categories.dart';
import 'package:to_do/View/screens/sub_screens/task_details.dart';
import 'package:to_do/View/theme/theme.dart';
import 'package:to_do/View/widgets/visual_utils/boxes.dart';
import 'package:to_do/View/widgets/visual_utils/buttons.dart';
import 'package:to_do/general_utils/navigation_helper.dart';
import 'package:to_do/general_utils/screen_size_helper.dart';
import 'package:to_do/View/widgets/visual_utils/themed_text.dart';

//Task Card Related Widgets

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task, required this.index});
  final TaskModel task;
  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Cached_Task_For_Updating.instance.index = index;
        NavigationHelper.navigateTo(context, TaskDetails(task: task));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: GreyBoxWithLinearCornersForCards(
          heightPortionFromScreenHeight: 0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TaskCheckBox(
                isDone: task.isDoneAsBool,
                id: task.id!,
              ),
              TitleAndDate(title: task.title, date: task.formattedDate),
              const Spacer(),
              CategoryAndPriority(
                  category:
                      In_Memory_Categories.instance.category(task.categoryId),
                  priority: task.priority!)
            ],
          ),
        ),
      ),
    );
  }
}

class TaskCheckBox extends StatefulWidget {
  const TaskCheckBox({super.key, required this.isDone, required this.id});
  final bool isDone;
  final int id;

  @override
  State<TaskCheckBox> createState() => _TaskCheckBoxState();
}

class _TaskCheckBoxState extends State<TaskCheckBox> {
  late bool isChecked = widget.isDone;
  void onChanged(bool? value) {
    if (value!) {
      BlocProvider.of<TaskCubit>(context, listen: false)
          .completeTask(widget.id);
    } else {
      BlocProvider.of<TaskCubit>(context, listen: false).undoneTask(widget.id);
    }
    setState(() {
      isChecked = value;
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
    return Expanded(
      child: ListView.builder(
        itemCount: tasks.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => TaskCard(
          task: tasks[index],
          index: index,
        ),
      ),
    );
  }
}

class CheckTitleEditRow extends StatelessWidget {
  const CheckTitleEditRow(
      {super.key, required this.isDone, required this.id, required this.title});
  final bool isDone;
  final int id;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TaskCheckBox(isDone: isDone, id: id),
        SizedBox(width: ScreenSizeHelper.width_P(context, 0.05)),
        BodyLargeText(text: title),
        const Spacer(),
        const EditTitleAndDescriptionButton()
      ],
    );
  }
}
