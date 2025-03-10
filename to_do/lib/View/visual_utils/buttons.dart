import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Model_View/cubit/login/login_cubit.dart';
import 'package:to_do/Model_View/cubit/sign_up/sign_up_cubit.dart';
import 'package:to_do/View/screens/login_screen.dart';
import 'package:to_do/View/screens/register_screen.dart';
import 'package:to_do/View/visual_utils/screen_size_helper.dart';
import 'package:to_do/View/visual_utils/themed_text.dart';
import 'package:to_do/general_utils/navigation_helper.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: ScreenSizeHelper.height_P(context, 0.055),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(4.5)),
            backgroundColor: const Color.fromARGB(255, 136, 117, 255)),
        onPressed: onPressed,
        child: BodyLargeText(text: text),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});
  @override
  Widget build(BuildContext context) {
    return AuthButton(
      text: 'Login',
      onPressed: () {
        BlocProvider.of<LoginCubit>(context, listen: false).login();
      },
    );
  }
}

class RegisterButton extends StatelessWidget {
  RegisterButton({super.key});
  @override
  Widget build(BuildContext context) {
    return AuthButton(
      text: 'Register',
      onPressed: () {
        BlocProvider.of<RegisterCubit>(context, listen: false).signUp();
      },
    );
  }
}

class DontHaveAccount extends StatelessWidget {
  const DontHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          NavigationHelper.openPage(context, const RegisterScreen());
        },
        child: const BodyMediumText(
          text: 'Dont have an account ? Register',
        ),
      ),
    );
  }
}

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
          onPressed: () {
            NavigationHelper.openPage(context, const LoginScreen());
          },
          child: const BodyMediumText(
            text: 'Already have an account ? Login',
          )),
    );
  }
}

class ExitButton extends StatelessWidget {
  const ExitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ));
  }
}
