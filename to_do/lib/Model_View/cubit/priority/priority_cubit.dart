import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do/Model_View/storage/added_task.dart';

part 'priority_state.dart';

class PriorityCubit extends Cubit<PriorityState> {
  PriorityCubit() : super(PriorityInitial());
  int priority = 1;
  void selectPriority(int priority) {
    this.priority = priority;
    emit(SelectedPriority(priority: priority));
  }

  int savePriority() {
    In_Memory_Task.priority = priority;
    return priority;
  }
}
