import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do/Model/repository/logged_user_repository.dart';
import 'package:to_do/Model/repository/task_repository.dart';
import 'package:to_do/Model/models/task_model.dart';
import 'package:to_do/Model_View/storage/added_task.dart';
import 'package:to_do/Model_View/storage/logged_user.dart';
part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial()) {
    // fetchTasks();
  }
  TaskRepository taskRepository = TaskRepository.instance;
  LoggedUserRepository loggedUserRepository = LoggedUserRepository.instance;

  List<TaskModel> tasks = [];

  Future fetchTasks() async {
    int id = await loggedUserRepository.lastLoggedUserId();
    tasks = await taskRepository.fetchTasks(id);
    if (tasks.isEmpty) {
      emit(EmptyTasks());
    } else {
      emit(LoadedTasks(tasks: tasks));
    }
  }

  Future addTask() async {
    In_Memory_Task.userId = In_Memory_Logged_User.instance.id;
    if (In_Memory_Task.task == null) {
      emit(OperationFailed(message: 'One field or more are empty'));
    } else {
      if (await taskRepository.addTask(In_Memory_Task.task!)) {
        emit(TaskAddedSuccessfully(tasks: tasks));
      } else {
        emit(OperationFailed(message: 'Something wrong happened'));
      }
    }
  }

  Future removeTask(int id) async {
    if (await taskRepository.removeTask(id)) {
      emit(TaskDeletedSuccessfully());
    } else {
      emit(OperationFailed(message: 'Something wrong happened'));
    }
  }

  Future updateTask(TaskModel task) async {
    if (await taskRepository.updateTask(task)) {
      emit(TaskUpdatedSuccessfully());
    } else {
      emit(OperationFailed(message: 'Something wrong happened'));
    }
  }
}
