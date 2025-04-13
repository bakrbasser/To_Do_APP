import 'package:flutter/material.dart';
import 'package:to_do/Model/constants/enums.dart';
import 'package:to_do/Model_View/cubit/task/task_crud/task_cubit.dart';
import 'package:to_do/View/widgets/visual_utils/boxes.dart';
import 'package:to_do/View/widgets/visual_utils/themed_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SortTasksDialog extends StatelessWidget {
  const SortTasksDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BoxWithCircularCorners(
      heightPortionFromScreenHeight: 0.45,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: const [
            Center(child: BodyLargeText(text: 'Sort indices by :')),
            SizedBox(height: 10),
            SortByTitle(),
            SortByDescription(),
            SortByDate(),
            SortByPriority(),
            SortByCategory()
          ],
        ),
      ),
    );
  }
}

class SortListTile extends StatelessWidget {
  const SortListTile(
      {super.key, required this.icon, required this.title, required this.mode});
  final Widget icon;
  final String title;
  final TasksSortModes mode;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Material(
        child: ListTile(
          leading: icon,
          title: BodyLargeText(text: title),
          onTap: () {
            context.read<TaskCubit>().sortTasks(mode);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class SortByTitle extends StatelessWidget {
  const SortByTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const SortListTile(
      icon: Icon(Icons.title),
      title: 'Sort by title',
      mode: TasksSortModes.byTitle,
    );
  }
}

class SortByDescription extends StatelessWidget {
  const SortByDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return const SortListTile(
      icon: Icon(Icons.description),
      title: 'Sort by description',
      mode: TasksSortModes.byDescription,
    );
  }
}

class SortByDate extends StatelessWidget {
  const SortByDate({super.key});

  @override
  Widget build(BuildContext context) {
    return const SortListTile(
      icon: Icon(Icons.calendar_month_rounded),
      title: 'Sort by date',
      mode: TasksSortModes.byDate,
    );
  }
}

class SortByCategory extends StatelessWidget {
  const SortByCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return const SortListTile(
      icon: Icon(Icons.category),
      title: 'Sort by category',
      mode: TasksSortModes.byCategory,
    );
  }
}

class SortByPriority extends StatelessWidget {
  const SortByPriority({super.key});

  @override
  Widget build(BuildContext context) {
    return const SortListTile(
      icon: Icon(Icons.flag),
      title: 'Sort by Priority',
      mode: TasksSortModes.byPriority,
    );
  }
}
