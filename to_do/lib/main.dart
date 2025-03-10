import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Model_View/cubit/login/login_cubit.dart';
import 'package:to_do/Model_View/cubit/sign_up/sign_up_cubit.dart';
import 'package:to_do/View/screens/register_screen.dart';
import 'package:to_do/View/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.instance.theme,
      home: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => RegisterCubit()),
            BlocProvider(create: (context) => LoginCubit()),
          ],
          child: RegisterScreen(),
        ),
      ),
    );
  }
}
