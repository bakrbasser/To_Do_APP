part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

class IncompatiblePassword extends SignUpState {}

class SigningUp extends SignUpState {}

class SignedUp extends SignUpState {}

class SignUpFailed extends SignUpState {}
