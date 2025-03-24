import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Model_View/cubit/login/login_cubit.dart';
import 'package:to_do/View/screens/main_screen.dart';
import 'package:to_do/View/widgets/visual_utils/buttons.dart';
import 'package:to_do/general_utils/screen_size_helper.dart';
import 'package:to_do/View/widgets/visual_utils/text_fields.dart';
import 'package:to_do/View/widgets/visual_utils/themed_text.dart';
import 'package:to_do/general_utils/navigation_helper.dart';
import 'package:to_do/general_utils/snack_bar_helper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: LoginListener(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(leading: const ExitButton()),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: ScreenSizeHelper.height_P(context, 0.06)),
                  const TitleLargeText(text: 'Login'),
                  SizedBox(height: ScreenSizeHelper.height_P(context, 0.06)),
                  const LoginForm(), // Extracted form fields
                  SizedBox(height: ScreenSizeHelper.height_P(context, 0.08)),
                  const LoginButton(),
                  SizedBox(height: ScreenSizeHelper.height_P(context, 0.015)),
                  const DontHaveAccount(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Widget to handle Bloc state changes (Extracted for readability)
class LoginListener extends StatelessWidget {
  final Widget child;

  const LoginListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailed) {
          SnackBarHelper.showMessage(context, 'User is not found');
        } else if (state is EmptyField) {
          SnackBarHelper.showMessage(context, 'One or more fields are empty');
        } else if (state is LoggedIn) {
          SnackBarHelper.showMessage(context, 'Registered');
          NavigationHelper.openPage(context, const MainScreen());
        }
      },
      child: child,
    );
  }
}

// Widget for the form fields (Extracted for maintainability)
class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BodyMediumText(text: 'Username'),
        SizedBox(height: ScreenSizeHelper.height_P(context, 0.015)),
        const LoginUsername(),
        SizedBox(height: ScreenSizeHelper.height_P(context, 0.03)),
        const BodyMediumText(text: 'Password'),
        SizedBox(height: ScreenSizeHelper.height_P(context, 0.015)),
        const LoginPassword(),
      ],
    );
  }
}
