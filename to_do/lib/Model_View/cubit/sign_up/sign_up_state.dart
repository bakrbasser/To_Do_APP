part of 'sign_up_cubit.dart';

@immutable
sealed class RegisterState {}

final class SignUpInitial extends RegisterState {}

class IncompatiblePassword extends RegisterState {}

class SigningUp extends RegisterState {}

class Registered extends RegisterState {}

class RegisterFailed extends RegisterState {}

class MissingField extends RegisterState {}
