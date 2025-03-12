import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do/Model/repository/task_repository.dart';
import 'package:to_do/Model/models/task_model.dart';
import 'package:to_do/Model_View/storage/added_task.dart';
part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  TaskRepository repository = TaskRepository.instance;

  Future fetchTasks() async {
    var res = await repository.fetchTasks();
    if (res.isEmpty) {
      emit(EmptyTasks());
    } else {
      emit(LoadedTasks(tasks: res));
    }
  }

  Future addTask() async {
    if (In_Memory_Task.task == null) {
      emit(OperationFailed(message: 'One field or more are empty'));
    } else {
      if (await repository.addTask(In_Memory_Task.task!)) {
        emit(TaskAddedSuccessfully());
      } else {
        emit(OperationFailed(message: 'Something wrong happened'));
      }
    }
  }

  Future removeTask(int id) async {
    if (await repository.removeTask(id)) {
      emit(TaskDeletedSuccessfully());
    } else {
      emit(OperationFailed(message: 'Something wrong happened'));
    }
  }

  Future updateTask(TaskModel task) async {
    if (await repository.updateTask(task)) {
      emit(TaskUpdatedSuccessfully());
    } else {
      emit(OperationFailed(message: 'Something wrong happened'));
    }
  }
}
