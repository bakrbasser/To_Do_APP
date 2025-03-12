import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do/Model/repository/user_repository.dart';
import 'package:to_do/Model/models/user_model.dart';

part 'sign_up_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(SignUpInitial());

  UserRepository repository = UserRepository.instance;
  String _username = '';
  String _password = '';
  String _confirmPassword = '';

  set username(String username) {
    _username = username;
  }

  set password(String password) {
    _password = password;
  }

  set confirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
  }

  Future<void> signUp() async {
    if (_password != _confirmPassword) {
      emit(IncompatiblePassword());
      return;
    }
    if (_username.isEmpty || _password.isEmpty || _confirmPassword.isEmpty) {
      emit(MissingField());
      return;
    }

    UserModel user = UserModel(id: 0, username: _username, password: _password);

    emit(SigningUp());
    var res = await repository.addUser(user);
    if (res) {
      emit(Registered());
    } else {
      emit(RegisterFailed());
    }
  }
}
