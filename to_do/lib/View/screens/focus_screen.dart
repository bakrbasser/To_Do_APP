import 'package:flutter/material.dart';
import 'package:to_do/View/visual_utils/themed_text.dart';

class FocusScreen extends StatelessWidget {
  const FocusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BodyMediumText(text: 'Focus'),
      ),
    );
  }
}
