import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Model_View/cubit/login/login_cubit.dart';
import 'package:to_do/Model_View/cubit/sign_up/sign_up_cubit.dart';
import 'package:to_do/Model_View/storage/added_category.dart';
import 'package:to_do/Model_View/storage/cached_task.dart';

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

class TaskCrudTextField extends StatelessWidget {
  const TaskCrudTextField(
      {super.key, required this.hintText, required this.onChanged});
  final String hintText;
  final Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          border: const UnderlineInputBorder(borderSide: BorderSide.none),
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyMedium),
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

class TaskTitle extends TaskCrudTextField {
  TaskTitle({super.key})
      : super(
          hintText: 'Title',
          onChanged: (p0) {
            Cached_Task_For_Adding_Fields.title = p0;
          },
        );
}

class TaskDescription extends TaskCrudTextField {
  TaskDescription({super.key})
      : super(
          hintText: 'Description',
          onChanged: (p0) {
            Cached_Task_For_Adding_Fields.description = p0;
          },
        );
}

class CategoryNameTextField extends AuthTextField {
  CategoryNameTextField({super.key})
      : super(
            hintText: 'Category name',
            obscureText: false,
            onChanged: (p0) {
              In_Memory_Category.name = p0;
            },
            type: TextInputType.text);
}
