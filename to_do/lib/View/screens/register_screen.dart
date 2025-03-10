import 'package:flutter/material.dart';
import 'package:to_do/View/visual_utils/buttons.dart';
import 'package:to_do/View/visual_utils/screen_size_helper.dart';
import 'package:to_do/View/visual_utils/text_fields.dart';
import 'package:to_do/View/visual_utils/themed_text.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const ExitButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: ScreenSizeHelper.height_P(context, 0.06)),
              const TitleLargeText(text: 'Register'),
              SizedBox(height: ScreenSizeHelper.height_P(context, 0.06)),
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
              SizedBox(height: ScreenSizeHelper.height_P(context, 0.08)),
              RegisterButton(),
              SizedBox(height: ScreenSizeHelper.height_P(context, 0.015)),
              const AlreadyHaveAccount()
            ],
          ),
        ),
      ),
    );
  }
}
