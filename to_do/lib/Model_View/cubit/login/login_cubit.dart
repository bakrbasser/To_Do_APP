import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do/Model/database/user_repository.dart';
import 'package:to_do/Model/models/user_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  UserRepository repository = UserRepository.instance;
  late String _username;
  late String _password;

  set username(String username) {
    _username = username;
  }

  set password(String password) {
    _password = password;
  }

  Future login() async {
    UserModel user = UserModel(id: 0, username: _username, password: _password);

    emit(LoggingIn());
    var userExist = await repository.checkUser(user);
    if (userExist) {
      emit(LoggedIn());
    } else {
      emit(LoginFailed());
    }
  }
}
