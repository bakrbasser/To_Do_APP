import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do/Model/repository/logged_user_repository.dart';

part 'logged_user_state.dart';

class LoggedUserCubit extends Cubit<LoggedUserState> {
  LoggedUserCubit() : super(LoggedUserInitial());
  LoggedUserRepository repository = LoggedUserRepository.instance;

  Future checkLoggedUser() async {
    int id = await repository.lastLoggedUserId();
    if (id != -1) {
      emit(LoggedUser());
    } else {
      emit(NoLoggedUser());
    }
  }
}
