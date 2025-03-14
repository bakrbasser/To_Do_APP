part of 'logged_user_cubit.dart';

@immutable
sealed class LoggedUserState {}

final class LoggedUserInitial extends LoggedUserState {}

class LoggedUser extends LoggedUserState {}

class NoLoggedUser extends LoggedUserState {}
