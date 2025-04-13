import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Model_View/cubit/custom_calendar/custom_calendar_cubit.dart';
import 'package:to_do/View/theme/theme.dart';
import 'package:to_do/View/widgets/visual_utils/boxes.dart';
import 'package:to_do/View/widgets/visual_utils/buttons.dart';
import 'package:to_do/View/widgets/visual_utils/themed_text.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({super.key});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomCalendarCubit(),
      child: GreyBoxWithLinearCornersForCards(
        heightPortionFromScreenHeight: 0.21,
        child: Column(
          children: [
            CustomDatePickerMonthAndYearSelector(
                year: DateTime.now().year, month: DateTime.now().month),
            BlocBuilder<CustomCalendarCubit, CustomCalendarState>(
              builder: (context, state) {
                return DaysListView(date: state.date);
              },
            )
          ],
        ),
      ),
    );
  }
}

class CustomDatePickerMonthAndYearSelector extends StatelessWidget {
  const CustomDatePickerMonthAndYearSelector(
      {super.key, required this.year, required this.month});
  final int year;
  final int month;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SelectPreviousMonthButton(),
        BlocBuilder<CustomCalendarCubit, CustomCalendarState>(
          builder: (context, state) {
            if (state is PickedMonth) {
              return MonthAndYearTitle(
                  year: state.date.year, month: state.date.month);
            } else if (state is CustomCalendarInitial) {
              return MonthAndYearTitle(
                  year: state.date.year, month: state.date.month);
            } else {
              return MonthAndYearTitle(
                  year: DateTime.now().year, month: DateTime.now().month);
            }
          },
        ),
        const SelectNextMonthButton()
      ],
    );
  }
}

class MonthAndYearTitle extends StatelessWidget {
  const MonthAndYearTitle({super.key, required this.year, required this.month});
  final int year;
  final int month;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BodyLargeText(
              text: DateFormat.MMMM().format(DateTime(year, month, 1))),
          BodySmallText(
              text: year.toString(), color: AppColors.instance.lessWhite)
        ],
      ),
    );
  }
}

class DaysListView extends StatelessWidget {
  const DaysListView({super.key, required this.date});
  final DateTime date;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: DateUtils.getDaysInMonth(date.year, date.month),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomDateDayButton(
              date: DateTime(date.year, date.month, index + 1)),
        ),
      ),
    );
  }
}
