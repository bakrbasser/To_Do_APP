import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Model_View/cubit/logged_user/logged_user_cubit.dart';
import 'package:to_do/View/screens/login_screen.dart';
import 'package:to_do/View/screens/main_screen.dart';
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
      home: BlocProvider(
        create: (context) => LoggedUserCubit(),
        child: const Scaffold(
          body: AppScreen(),
        ),
      ),
    );
  }
}

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<LoggedUserCubit>(context, listen: false).checkLoggedUser();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoggedUserCubit, LoggedUserState>(
      builder: (context, state) {
        if (state is LoggedUser) {
          return const MainScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
