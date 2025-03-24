import 'package:flutter/material.dart';

class TitleLargeText extends StatelessWidget {
  final Color color;
  final String text;
  const TitleLargeText(
      {super.key, required this.text, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(color: color));
  }
}

class TitleMediumText extends StatelessWidget {
  final Color color;
  final String text;
  const TitleMediumText(
      {super.key, required this.text, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: color));
  }
}

class TitleSmallText extends StatelessWidget {
  final Color color;
  final String text;
  const TitleSmallText(
      {super.key, required this.text, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(color: color));
  }
}

class BodyLargeText extends StatelessWidget {
  final Color color;
  final String text;
  const BodyLargeText(
      {super.key, required this.text, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: color));
  }
}

class BodyMediumText extends StatelessWidget {
  final Color color;
  final String text;
  const BodyMediumText(
      {super.key, required this.text, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: color));
  }
}

class BodySmallText extends StatelessWidget {
  final Color color;
  final String text;
  const BodySmallText(
      {super.key, required this.text, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: color));
  }
}
