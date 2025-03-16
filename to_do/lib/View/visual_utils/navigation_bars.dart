import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Model_View/cubit/main_navigation/main_navigation_cubit.dart';
import 'package:to_do/View/visual_utils/buttons.dart';
import 'package:to_do/View/visual_utils/screen_size_helper.dart';

class MainScreenNavigationBar extends StatefulWidget {
  const MainScreenNavigationBar({super.key});

  @override
  State<MainScreenNavigationBar> createState() =>
      _MainScreenNavigationBarState();
}

class _MainScreenNavigationBarState extends State<MainScreenNavigationBar> {
  void _onDestinationSelected(int index) {
    BlocProvider.of<MainNavigationCubit>(context, listen: false).caller(index);
    setState(() {
      selectedIndex = index;
    });
  }

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: _onDestinationSelected,
      height: ScreenSizeHelper.height_P(context, 0.12),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_filled), label: 'Index'),
        NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined), label: 'Calendar'),
        OpenAddTaskScreen(),
        NavigationDestination(
          icon: Icon(Icons.watch_later_outlined),
          label: 'Focus',
        ),
        NavigationDestination(
            icon: Icon(Icons.person_outline_outlined), label: 'Profile'),
      ],
    );
  }
}
