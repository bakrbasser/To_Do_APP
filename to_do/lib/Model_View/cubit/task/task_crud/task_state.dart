part of 'task_cubit.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

class TaskStateWithList extends TaskState {
  final List<TaskModel> tasks;

  TaskStateWithList({required this.tasks});
}

class OperationFailed extends TaskState {
  final String message;

  OperationFailed({required this.message});
}

class LoadingTasks extends TaskState {}

class EmptyTasks extends TaskState {}

class LoadedTasks extends TaskStateWithList {
  LoadedTasks({required super.tasks});
}

class TaskDeletedSuccessfully extends TaskState {}

class TaskAddedSuccessfully extends TaskStateWithList {
  TaskAddedSuccessfully({required super.tasks});
}

class TaskUpdatedSuccessfully extends TaskState {}
