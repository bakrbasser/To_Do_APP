import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Model_View/cubit/task/task_crud/task_cubit.dart';
import 'package:to_do/View/widgets/visual_utils/buttons.dart';
import 'package:to_do/View/widgets/visual_utils/themed_text.dart';
import 'package:to_do/View/widgets/specified_function_widgets/task_widgets.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TaskCubit>().fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SortTasksButton(),
        title: const BodyLargeText(text: 'Index'),
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is LoadingTasks) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TaskStateWithList) {
            return TasksList(tasks: state.tasks);
          } else {
            return const EmptyTasks();
          }
        },
      ),
    );
  }
}

class EmptyTasks extends StatelessWidget {
  const EmptyTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Image.asset('assets/empty.png')),
        const BodyLargeText(text: 'What do you want to do today?'),
        const BodyMediumText(text: 'Tap + to add your tasks')
      ],
    );
  }
}
