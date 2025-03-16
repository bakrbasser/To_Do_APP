import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:to_do/View/screens/index_screen.dart';
import 'package:to_do/View/screens/calendar_screen.dart';
import 'package:to_do/View/screens/focus_screen.dart';
import 'package:to_do/View/screens/profile_screen.dart';

part 'main_navigation_state.dart';

class MainNavigationCubit extends Cubit<MainNavigationState> {
  MainNavigationCubit() : super(const MainNavigationInitial());

  void caller(int index) {
    switch (index) {
      case 0:
        toIndex();
        break;
      case 1:
        toCalendar();
        break;
      case 3:
        toFocus();
        break;
      case 4:
        toProfile();
        break;
      default:
        toIndex();
        break;
    }
  }

  void toIndex() {
    emit(const MainNavigationInitial());
  }

  void toCalendar() {
    emit(const Calendar());
  }

  void toFocus() {
    emit(const Focus());
  }

  void toProfile() {
    emit(const Profile());
  }
}
