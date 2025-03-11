import 'package:flutter/material.dart';
import 'package:to_do/View/visual_utils/themed_text.dart';

class SnackBarHelper {
  static void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: BodyMediumText(text: message),
      ),
    );
  }
}
