import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do/Model/repository/logged_user_repository.dart';
import 'package:to_do/Model/repository/user_repository.dart';
import 'package:to_do/Model/models/user_model.dart';
import 'package:to_do/Model_View/storage/logged_user.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  UserRepository userRepository = UserRepository.instance;
  LoggedUserRepository loggedUserRepository = LoggedUserRepository.instance;

  String _username = '';
  String _password = '';

  set username(String username) {
    _username = username;
  }

  set password(String password) {
    _password = password;
  }

  Future login() async {
    if (_username.isEmpty || _password.isEmpty) {
      emit(EmptyField());
      return;
    }
    UserModel user = UserModel(id: 0, username: _username, password: _password);

    emit(LoggingIn());
    int userId = await userRepository.checkUser(user);
    if (userId != -1) {
      In_Memory_Logged_User.instance.id = userId;
      emit(LoggedIn());
      loggedUserRepository.login(userId);
    } else {
      emit(LoginFailed());
    }
  }
}
