import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do/Model/database/user_repository.dart';
import 'package:to_do/Model/models/user_model.dart';

part 'sign_up_state.dart';

class RegisterCubit extends Cubit<SignUpState> {
  RegisterCubit() : super(SignUpInitial());

  UserRepository repository = UserRepository.instance;
  late String _username;
  late String _password;
  late String _confirmPassword;

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
    UserModel user = UserModel(id: 0, username: _username, password: _password);

    emit(SigningUp());
    var res = await repository.addUser(user);
    if (res) {
      emit(SignedUp());
    } else {
      emit(SignUpFailed());
    }
  }
}
