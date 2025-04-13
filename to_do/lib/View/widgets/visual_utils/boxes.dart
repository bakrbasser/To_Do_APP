import 'package:flutter/material.dart';
import 'package:to_do/View/theme/theme.dart';
import 'package:to_do/general_utils/screen_size_helper.dart';

class BoxWithCircularCorners extends StatelessWidget {
  const BoxWithCircularCorners(
      {super.key,
      required this.heightPortionFromScreenHeight,
      required this.child,
      this.widthPortionFromScreenWidth = 1,
      this.radius = 25,
      this.color = const Color(0xff363636)});

  final Color color;
  final Widget child;
  final double heightPortionFromScreenHeight;
  final double widthPortionFromScreenWidth;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius), color: color),
      height: ScreenSizeHelper.height_P(context, heightPortionFromScreenHeight),
      width: ScreenSizeHelper.width_P(context, widthPortionFromScreenWidth),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenSizeHelper.width_P(context, 0.07)),
        child: child,
      ),
    );
  }
}

class GreyBoxWithLinearCorners extends StatelessWidget {
  const GreyBoxWithLinearCorners({
    super.key,
    required this.heightPortionFromScreenHeight,
    required this.child,
    this.widthPortionFromScreenWidth = 1,
    this.paddingHeightPortionFromScreenHeight = 0.01,
    this.paddingWidthPortionFromScreenWidth = 0.07,
  });

  final Widget child;
  final double heightPortionFromScreenHeight;
  final double widthPortionFromScreenWidth;
  final double paddingHeightPortionFromScreenHeight;
  final double paddingWidthPortionFromScreenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.instance.grey),
      height: ScreenSizeHelper.height_P(context, heightPortionFromScreenHeight),
      width: ScreenSizeHelper.width_P(context, widthPortionFromScreenWidth),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenSizeHelper.width_P(
                context, paddingWidthPortionFromScreenWidth),
            vertical: ScreenSizeHelper.height_P(
                context, paddingHeightPortionFromScreenHeight)),
        child: child,
      ),
    );
  }
}

class GreyBoxWithLinearCornersForCards extends StatelessWidget {
  const GreyBoxWithLinearCornersForCards({
    super.key,
    required this.heightPortionFromScreenHeight,
    required this.child,
    this.widthPortionFromScreenWidth = 1,
    this.padding = 1,
  });

  final Widget child;
  final double heightPortionFromScreenHeight;
  final double widthPortionFromScreenWidth;
  final double padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.instance.grey),
      height: ScreenSizeHelper.height_P(context, heightPortionFromScreenHeight),
      width: ScreenSizeHelper.width_P(context, widthPortionFromScreenWidth),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: child,
      ),
    );
  }
}

class BoxWithCircularCornersForSmallButtons extends StatelessWidget {
  const BoxWithCircularCornersForSmallButtons({
    super.key,
    this.heightPortionFromScreenHeight = 0.09,
    required this.child,
    this.widthPortionFromScreenWidth = 0.15,
    this.radius = 5,
    this.color = const Color(0xff272727),
    this.horizontalPadding = 8,
    this.verticalPadding = 7,
  });

  final Color color;
  final Widget child;
  final double heightPortionFromScreenHeight;
  final double widthPortionFromScreenWidth;
  final double radius;
  final double horizontalPadding;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius), color: color),
      height: ScreenSizeHelper.height_P(context, heightPortionFromScreenHeight),
      width: ScreenSizeHelper.width_P(context, widthPortionFromScreenWidth),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        child: child,
      ),
    );
  }
}
