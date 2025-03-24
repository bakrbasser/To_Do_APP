import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do/Model/constants/enums.dart';
import 'package:to_do/Model/repository/logged_user_repository.dart';
import 'package:to_do/Model/repository/task_repository.dart';
import 'package:to_do/Model/models/task_model.dart';
import 'package:to_do/Model_View/storage/cached_task.dart';
import 'package:to_do/Model_View/storage/logged_user.dart';
part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  TaskRepository taskRepository = TaskRepository.instance;
  LoggedUserRepository loggedUserRepository = LoggedUserRepository.instance;

  List<TaskModel> tasks = [];

  Future fetchTasks() async {
    emit(LoadingTasks());
    int id = await loggedUserRepository.lastLoggedUserId();
    tasks = await taskRepository.fetchTasks(id);
    if (tasks.isEmpty) {
      emit(EmptyTasks());
    } else {
      emit(LoadedTasks(tasks: tasks));
    }
  }

  Future addTask() async {
    Cached_Task_For_Adding_Fields.userId = In_Memory_Logged_User.instance.id;
    var task = Cached_Task_For_Adding_Fields.cachedTask;
    if (task == null) {
      emit(OperationFailed(message: 'One field or more are empty'));
    } else {
      if (await taskRepository.addTask(task)) {
        var addedTask = await taskRepository.fetchLastTaskAfterAdding();
        tasks.add(addedTask);
        emit(TaskAddedSuccessfully(tasks: tasks));
      } else {
        emit(OperationFailed(message: 'Something wrong happened'));
      }
    }
  }

  Future completeTask(int id) async {
    await taskRepository.completeTask(id);
  }

  Future undoneTask(int id) async {
    await taskRepository.undoneTask(id);
  }

  Future removeTask(int id) async {
    if (await taskRepository.removeTask(id)) {
      tasks.removeWhere((element) => element.id == id);
      emit(TaskDeletedSuccessfully(tasks: tasks));
    } else {
      emit(OperationFailed(message: 'Something wrong happened'));
    }
  }

  Future<void> updateTask(UpdateModes mode) async {
    var task = Cached_Task_For_Updating.instance.task;
    int index = Cached_Task_For_Updating.instance.index;
    bool isUpdated = false;

    switch (mode) {
      case UpdateModes.category:
        isUpdated =
            await taskRepository.updateCategoryId(task.id!, task.categoryId);
        break;
      case UpdateModes.title:
        isUpdated = await taskRepository.updateTitle(task.id!, task.title);
        break;
      case UpdateModes.description:
        isUpdated =
            await taskRepository.updateDescription(task.id!, task.description!);
        break;
      case UpdateModes.date:
        isUpdated = await taskRepository.updateDate(task.id!, task.date);
        break;
      case UpdateModes.priority:
        isUpdated =
            await taskRepository.updatePriority(task.id!, task.priority!);
        break;
      default:
        // If no specific field is provided, update all fields
        isUpdated = false;
        break;
    }

    if (isUpdated) {
      tasks[index] = task;
      emit(TaskUpdatedSuccessfully(tasks: tasks));
    } else {
      emit(OperationFailed(message: 'Something wrong happened'));
    }
  }
}
