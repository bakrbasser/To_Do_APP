part of 'main_navigation_cubit.dart';

@immutable
sealed class MainNavigationState {
  final Widget widget;

  const MainNavigationState({required this.widget});
}

final class MainNavigationInitial extends MainNavigationState {
  const MainNavigationInitial() : super(widget: const IndexScreen());
}

class Calendar extends MainNavigationState {
  const Calendar() : super(widget: const CalendarScreen());
}

class Focus extends MainNavigationState {
  const Focus() : super(widget: const FocusScreen());
}

class Profile extends MainNavigationState {
  const Profile() : super(widget: const ProfileScreen());
}
