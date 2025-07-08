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

  List<TaskModel> emittedTasks = [];

  Future fetchTasks() async {
    emit(LoadingTasks());
    int id = await loggedUserRepository.lastLoggedUserId();
    tasks = await taskRepository.fetchTasks(id);
    if (tasks.isEmpty) {
      emit(EmptyTasks());
    } else {
      emittedTasks = tasks;
      emit(LoadedTasks(tasks: emittedTasks));
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
        emittedTasks.add(addedTask);
        emit(TaskAddedSuccessfully(tasks: emittedTasks));
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
      emit(TaskDeletedSuccessfully(tasks: emittedTasks));
    } else {
      emit(OperationFailed(message: 'Something wrong happened'));
    }
  }

  Future<void> updateTask(UpdateModes? mode) async {
    //TODO: Handle Editing while filtered

    var task = Cached_Task_For_Updating.instance.task;
    int index = Cached_Task_For_Updating.instance.index;
    bool isUpdated = false;

    switch (mode) {
      case UpdateModes.category:
        isUpdated =
            await taskRepository.updateCategoryId(task.id!, task.categoryId);
        break;
      case UpdateModes.titleAndDescription:
        List<bool> res = await Future.wait([
          taskRepository.updateTitle(task.id!, task.title),
          taskRepository.updateDescription(task.id!, task.description!)
        ]);
        isUpdated = res.reduce(
          (value, element) => value && element,
        );
        break;
      case UpdateModes.date:
        isUpdated = await taskRepository.updateDate(task.id!, task.date);
        break;
      case UpdateModes.priority:
        isUpdated =
            await taskRepository.updatePriority(task.id!, task.priority!);
        break;
      default:
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

  void sortTasks(TasksSortModes sortMode) {
    // Create a copy of the original list to avoid modifying it directly

    switch (sortMode) {
      case TasksSortModes.byTitle:
        emittedTasks.sort((a, b) => a.title.compareTo(b.title));
        break;
      case TasksSortModes.byDescription:
        emittedTasks.sort((a, b) {
          final descA = a.description ?? '';
          final descB = b.description ?? '';
          return descA.compareTo(descB);
        });
        break;
      case TasksSortModes.byDate:
        emittedTasks.sort((a, b) => a.date.compareTo(b.date));
        break;
      case TasksSortModes.byPriority:
        emittedTasks.sort((a, b) {
          final priorityA = a.priority ?? 0;
          final priorityB = b.priority ?? 0;
          // Sort in descending order (higher priority first)
          return priorityB.compareTo(priorityA);
        });
        break;
      case TasksSortModes.byCategory:
        emittedTasks.sort((a, b) => a.categoryId.compareTo(b.categoryId));
        break;
    }
    emit(
      TaskSortedSuccessfully(tasks: emittedTasks),
    );
  }

  void filterTasksByTitle(String searchQuery) {
    if (searchQuery.isEmpty) {
      emit(TasksFiltered(tasks: tasks));
    } else {
      emittedTasks = tasks.where((task) {
        final taskTitle = task.title.toLowerCase();
        final query = searchQuery.toLowerCase();

        return taskTitle.contains(query);
      }).toList();
      emit(TasksFiltered(tasks: emittedTasks));
    }
  }

  void filterTaskByDate(String date) {
    emittedTasks =
        tasks.where((element) => element.formattedDate == date).toList();
    if (emittedTasks.isNotEmpty) {
      emit(TasksFiltered(tasks: emittedTasks));
    } else {
      emit(EmptyTasks());
    }
  }
}
