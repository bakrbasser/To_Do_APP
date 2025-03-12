part of 'task_cubit.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

class OperationFailed extends TaskState {
  final String message;

  OperationFailed({required this.message});
}

class LoadingTasks extends TaskState {}

class EmptyTasks extends TaskState {}

class LoadedTasks extends TaskState {
  final List<TaskModel> tasks;

  LoadedTasks({required this.tasks});
}

class TaskDeletedSuccessfully extends TaskState {}

class TaskAddedSuccessfully extends TaskState {}

class TaskUpdatedSuccessfully extends TaskState {}
