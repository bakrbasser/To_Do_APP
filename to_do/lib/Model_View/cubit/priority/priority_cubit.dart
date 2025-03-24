import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do/Model_View/storage/cached_task.dart';

part 'priority_state.dart';

class PriorityCubit extends Cubit<PriorityState> {
  PriorityCubit() : super(PriorityInitial());
  int priority = 1;
  void selectPriority(int priority) {
    this.priority = priority;
    emit(SelectedPriority(priority: priority));
  }

  int savePriority() {
    Cached_Task_For_Adding_Fields.priority = priority;
    return priority;
  }
}
