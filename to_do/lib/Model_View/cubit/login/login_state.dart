part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoggingIn extends LoginState {}

class LoggedIn extends LoginState {}

class LoginFailed extends LoginState {}

class EmptyField extends LoginState {}
