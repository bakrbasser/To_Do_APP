import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Model/models/category_model.dart';
import 'package:to_do/Model_View/cubit/categories/categories_cubit.dart';
import 'package:to_do/View/theme/theme.dart';
import 'package:to_do/View/visual_utils/buttons.dart';
import 'package:to_do/View/visual_utils/screen_size_helper.dart';
import 'package:to_do/View/visual_utils/themed_text.dart';

class TaskCategoryDialog extends StatelessWidget {
  const TaskCategoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.instance.navigationBarBackground,
      ),
      height: ScreenSizeHelper.height_P(context, 0.75),
      width: ScreenSizeHelper.width_P(context, 0.95),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const TitleMediumText(text: 'Choose Category'),
            SizedBox(height: ScreenSizeHelper.height_P(context, 0.05)),
            BlocProvider(
              create: (context) => CategoriesCubit(),
              child: const CategoriesBody(),
            ),
            const Spacer(),
            const AddCategoryButton()
          ],
        ),
      ),
    );
  }
}

class CategoriesBody extends StatefulWidget {
  const CategoriesBody({super.key});

  @override
  State<CategoriesBody> createState() => _CategoriesBodyState();
}

class _CategoriesBodyState extends State<CategoriesBody> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoriesCubit>(context, listen: false).fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is FetchedCategories) {
          return CategoriesGridView(categories: state.categories);
        } else {
          return const NoCategoriesWereFound();
        }
      },
    );
  }
}

class CategoriesGridView extends StatelessWidget {
  const CategoriesGridView({super.key, required this.categories});
  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenSizeHelper.height_P(context, 0.5),
      child: GridView.builder(
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) => CategoryButton(
          category: categories[index],
        ),
      ),
    );
  }
}

class NoCategoriesWereFound extends StatelessWidget {
  const NoCategoriesWereFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TitleMediumText(text: 'No categories were found'),
        BodyLargeText(text: 'Please add some categories')
      ],
    );
  }
}
