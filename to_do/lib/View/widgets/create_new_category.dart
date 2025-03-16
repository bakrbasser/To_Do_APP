import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Model_View/cubit/categories/categories_cubit.dart';
import 'package:to_do/View/visual_utils/buttons.dart';
import 'package:to_do/View/visual_utils/color_picker.dart';
import 'package:to_do/View/visual_utils/screen_size_helper.dart';
import 'package:to_do/View/visual_utils/text_fields.dart';
import 'package:to_do/View/visual_utils/themed_text.dart';
import 'package:to_do/general_utils/snack_bar_helper.dart';

class CreateNewCategory extends StatelessWidget {
  const CreateNewCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesCubit(),
      child: BlocListener<CategoriesCubit, CategoriesState>(
        listener: (context, state) {
          if (state is AddedSuccessfully) {
            SnackBarHelper.showMessage(context, 'Added Successfully');
            Navigator.pop(context);
          } else if (state is AddingFailed) {
            SnackBarHelper.showMessage(context, 'One field or more is empty');
          }
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleMediumText(text: 'Create new category'),
                SizedBox(height: ScreenSizeHelper.height_P(context, 0.04)),
                const BodyLargeText(text: 'Category name :'),
                SizedBox(height: ScreenSizeHelper.height_P(context, 0.02)),
                CategoryNameTextField(),
                SizedBox(height: ScreenSizeHelper.height_P(context, 0.04)),
                const BodyLargeText(text: 'Category color :'),
                const BlockPickerListExample(),
                const Spacer(),
                const PriorityButtons()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PriorityButtons extends StatelessWidget {
  const PriorityButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [CancelButton(), Spacer(), CreateCategoryButton()],
    );
  }
}
