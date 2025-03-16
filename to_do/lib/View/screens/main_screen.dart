import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Model_View/cubit/main_navigation/main_navigation_cubit.dart';
import 'package:to_do/View/visual_utils/navigation_bars.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainNavigationCubit(),
      child: Scaffold(
        bottomNavigationBar: const MainScreenNavigationBar(),
        body: BlocBuilder<MainNavigationCubit, MainNavigationState>(
          builder: (context, state) {
            return state.widget;
          },
        ),
      ),
    );
  }
}
