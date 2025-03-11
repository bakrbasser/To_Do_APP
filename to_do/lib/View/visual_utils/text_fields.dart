import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Model_View/cubit/login/login_cubit.dart';
import 'package:to_do/Model_View/cubit/sign_up/sign_up_cubit.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField(
      {super.key,
      required this.hintText,
      required this.type,
      required this.obscureText,
      required this.onChanged});
  final String hintText;
  final TextInputType type;
  final bool obscureText;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      obscureText: obscureText,
      keyboardType: type,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
      ),
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}

class UsernameTextField extends AuthTextField {
  const UsernameTextField({super.key, required super.onChanged})
      : super(
            hintText: 'Enter Your Username',
            type: TextInputType.emailAddress,
            obscureText: false);
}

class PasswordTextField extends AuthTextField {
  const PasswordTextField({super.key, required super.onChanged})
      : super(
            hintText: 'Enter Your Password',
            type: TextInputType.visiblePassword,
            obscureText: true);
}

class LoginUsername extends StatelessWidget {
  const LoginUsername({super.key});
  @override
  Widget build(BuildContext context) {
    return UsernameTextField(
      onChanged: (p0) {
        BlocProvider.of<LoginCubit>(context, listen: false).username = p0;
      },
    );
  }
}

class RegisterUsername extends StatelessWidget {
  const RegisterUsername({super.key});
  @override
  Widget build(BuildContext context) {
    return UsernameTextField(
      onChanged: (p0) {
        BlocProvider.of<RegisterCubit>(context, listen: false).username = p0;
      },
    );
  }
}

class LoginPassword extends StatelessWidget {
  const LoginPassword({super.key});
  @override
  Widget build(BuildContext context) {
    return PasswordTextField(
      onChanged: (p0) {
        BlocProvider.of<LoginCubit>(context, listen: false).password = p0;
      },
    );
  }
}

class RegisterPassword extends StatelessWidget {
  const RegisterPassword({super.key});
  @override
  Widget build(BuildContext context) {
    return PasswordTextField(
      onChanged: (p0) {
        BlocProvider.of<RegisterCubit>(context, listen: false).password = p0;
      },
    );
  }
}

class RegisterConfirmPassword extends StatelessWidget {
  const RegisterConfirmPassword({super.key});
  @override
  Widget build(BuildContext context) {
    return PasswordTextField(
      onChanged: (p0) {
        BlocProvider.of<RegisterCubit>(context, listen: false).confirmPassword =
            p0;
      },
    );
  }
}
