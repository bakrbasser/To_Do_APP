import 'package:flutter/material.dart';
import 'package:to_do/Model/constants/enums.dart';

class DialogHelper {
  static void dialogShower(BuildContext context, Widget widget) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: widget,
        );
      },
    );
  }

  static Future dialogShowerFuture(BuildContext context, Widget widget) async {
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: widget,
        );
      },
    );
  }

  static Future<String?> dataPickerForTask(
      BuildContext context, TaskFieldsModes mode) async {
    DateTime? date;
    date = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 1));
    return date.toString();
  }
}
