import 'package:flutter/material.dart';

abstract class BaseText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const BaseText({super.key, required this.text, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: style);
  }
}

class TitleLargeText extends StatelessWidget {
  final String text;

  const TitleLargeText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.titleLarge);
  }
}

class TitleMediumText extends StatelessWidget {
  final String text;

  const TitleMediumText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.titleMedium);
  }
}

class TitleSmallText extends StatelessWidget {
  final String text;

  const TitleSmallText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.titleSmall);
  }
}

class BodyLargeText extends StatelessWidget {
  final String text;

  const BodyLargeText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.bodyLarge);
  }
}

class BodyMediumText extends StatelessWidget {
  final String text;

  const BodyMediumText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.bodyMedium);
  }
}

class BodySmallText extends StatelessWidget {
  final String text;

  const BodySmallText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.bodySmall);
  }
}
