import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationHelper {
  static void navigateTo(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }

  static void navigateToAndPassCubit<T extends Cubit<dynamic>>(
    BuildContext context,
    Widget widget,
  ) {
    // Retrieve the Cubit from the current context
    final cubit = BlocProvider.of<T>(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: cubit, // Pass the existing Cubit
          child: widget,
        ),
      ),
    );
  }

  static void openPage(BuildContext context, Widget widget) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }
}
