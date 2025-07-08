import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Model_View/cubit/task/task_crud/task_cubit.dart';
import 'package:to_do/View/screens/main_screens/index_screen.dart';
import 'package:to_do/View/widgets/specified_function_widgets/task_widgets.dart';
import 'package:to_do/View/widgets/visual_utils/custom_date_time_picker.dart';
import 'package:to_do/View/widgets/visual_utils/themed_text.dart';
import 'package:to_do/general_utils/local_date_utilities.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const BodyLargeText(text: 'Calendar'),
      ),
      body: const Column(
        children: [
          CustomDatePicker(),
          SizedBox(height: 30),
          TaskListByCalendar(),
        ],
      ),
    );
  }
}

class TaskListByCalendar extends StatefulWidget {
  const TaskListByCalendar({super.key});

  @override
  State<TaskListByCalendar> createState() => _TaskListByCalendarState();
}

class _TaskListByCalendarState extends State<TaskListByCalendar> {
  @override
  void initState() {
    super.initState();
    context
        .read<TaskCubit>()
        .filterTaskByDate(LocalDateUtilities.formattedDate(DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if (state is TaskStateWithList) {
          return TasksList(tasks: state.tasks);
        } else {
          return const Center(
            child: EmptyTasksPresentation(),
          );
        }
      },
    );
  }
}
