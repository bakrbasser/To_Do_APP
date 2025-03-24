import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Model_View/cubit/sign_up/sign_up_cubit.dart';
import 'package:to_do/View/screens/auth_screens/login_screen.dart';
import 'package:to_do/View/widgets/visual_utils/buttons.dart';
import 'package:to_do/general_utils/screen_size_helper.dart';
import 'package:to_do/View/widgets/visual_utils/text_fields.dart';
import 'package:to_do/View/widgets/visual_utils/themed_text.dart';
import 'package:to_do/general_utils/navigation_helper.dart';
import 'package:to_do/general_utils/snack_bar_helper.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: RegisterListener(
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
                  const TitleLargeText(text: 'Register'),
                  SizedBox(height: ScreenSizeHelper.height_P(context, 0.06)),
                  const RegisterForm(), // Extracted form fields
                  SizedBox(height: ScreenSizeHelper.height_P(context, 0.08)),
                  const RegisterButton(),
                  SizedBox(height: ScreenSizeHelper.height_P(context, 0.015)),
                  const AlreadyHaveAccount(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterListener extends StatelessWidget {
  final Widget child;

  const RegisterListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailed) {
          SnackBarHelper.showMessage(context, 'Username already exists');
        } else if (state is IncompatiblePassword) {
          SnackBarHelper.showMessage(
              context, 'The two passwords are not identical');
        } else if (state is Registered) {
          SnackBarHelper.showMessage(context, 'Registered Successfully');
          NavigationHelper.openPage(context, const LoginScreen());
        } else if (state is MissingField) {
          SnackBarHelper.showMessage(context, 'One or more fields are empty');
        }
      },
      child: child,
    );
  }
}

// Widget for the form fields (Extracted for maintainability)
class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BodyMediumText(text: 'Username'),
        SizedBox(height: ScreenSizeHelper.height_P(context, 0.015)),
        const RegisterUsername(),
        SizedBox(height: ScreenSizeHelper.height_P(context, 0.03)),
        const BodyMediumText(text: 'Password'),
        SizedBox(height: ScreenSizeHelper.height_P(context, 0.015)),
        const RegisterPassword(),
        SizedBox(height: ScreenSizeHelper.height_P(context, 0.03)),
        const BodyMediumText(text: 'Confirm Password'),
        SizedBox(height: ScreenSizeHelper.height_P(context, 0.015)),
        const RegisterConfirmPassword(),
      ],
    );
  }
}
