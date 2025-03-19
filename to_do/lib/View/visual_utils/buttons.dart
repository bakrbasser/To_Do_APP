import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Model/models/category_model.dart';
import 'package:to_do/Model_View/cubit/categories/categories_cubit.dart';
import 'package:to_do/Model_View/cubit/login/login_cubit.dart';
import 'package:to_do/Model_View/cubit/priority/priority_cubit.dart';
import 'package:to_do/Model_View/cubit/sign_up/sign_up_cubit.dart';
import 'package:to_do/Model_View/cubit/task/task_crud/task_cubit.dart';
import 'package:to_do/Model_View/storage/added_category.dart';
import 'package:to_do/Model_View/storage/added_task.dart';
import 'package:to_do/View/widgets/create_new_category.dart';
import 'package:to_do/View/widgets/dialogs/add_task_dialog.dart';
import 'package:to_do/View/screens/login_screen.dart';
import 'package:to_do/View/screens/register_screen.dart';
import 'package:to_do/View/theme/theme.dart';
import 'package:to_do/View/visual_utils/screen_size_helper.dart';
import 'package:to_do/View/visual_utils/themed_text.dart';
import 'package:to_do/View/widgets/dialogs/task_category_dialog.dart';
import 'package:to_do/View/widgets/dialogs/task_priority_dialog.dart';
import 'package:to_do/general_utils/dialog_helper.dart';
import 'package:to_do/general_utils/navigation_helper.dart';
import 'package:to_do/general_utils/snack_bar_helper.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: ScreenSizeHelper.height_P(context, 0.055),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(4.5)),
            backgroundColor: const Color.fromARGB(255, 136, 117, 255)),
        onPressed: onPressed,
        child: BodyLargeText(text: text),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});
  @override
  Widget build(BuildContext context) {
    return AuthButton(
      text: 'Login',
      onPressed: () {
        BlocProvider.of<LoginCubit>(context, listen: false).login();
      },
    );
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});
  @override
  Widget build(BuildContext context) {
    return AuthButton(
      text: 'Register',
      onPressed: () {
        BlocProvider.of<RegisterCubit>(context, listen: false).signUp();
      },
    );
  }
}

class DontHaveAccount extends StatelessWidget {
  const DontHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          NavigationHelper.openPage(context, const RegisterScreen());
        },
        child: const BodyMediumText(
          text: 'Dont have an account ? Register',
        ),
      ),
    );
  }
}

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
          onPressed: () {
            NavigationHelper.openPage(context, const LoginScreen());
          },
          child: const BodyMediumText(
            text: 'Already have an account ? Login',
          )),
    );
  }
}

class ExitButton extends StatelessWidget {
  const ExitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ));
  }
}

class SortTasksButton extends StatelessWidget {
  const SortTasksButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () {}, icon: const Icon(Icons.sort));
  }
}

class OpenAddTaskScreen extends StatelessWidget {
  const OpenAddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: IconButton.filled(
        onPressed: () {
          In_Memory_Task.reset();
          DialogHelper.dialogShower(context, const AddTaskDialog());
        },
        icon: const Icon(
          Icons.add,
          size: 35,
        ),
        style: IconButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: AppColors.instance.appPurple),
      ),
    );
  }
}

class PickTaskDateButton extends StatelessWidget {
  const PickTaskDateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          In_Memory_Task.date = await DialogHelper.dataPicker(context);
        },
        icon: const Icon(
          Icons.watch_later_outlined,
          color: Colors.white,
        ));
  }
}

class PickTaskCategory extends StatelessWidget {
  const PickTaskCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          DialogHelper.dialogShower(context, const TaskCategoryDialog());
        },
        icon: const Icon(
          Icons.discount_outlined,
          color: Colors.white,
        ));
  }
}

class PickTaskPriority extends StatelessWidget {
  const PickTaskPriority({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          DialogHelper.dialogShower(context, const TaskPriorityDialog());
        },
        icon: const Icon(
          Icons.flag_outlined,
          color: Colors.white,
        ));
  }
}

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is TaskAddedSuccessfully) {
          SnackBarHelper.showMessage(context, 'Task was added successfully');
          Navigator.pop(context);
        } else if (state is OperationFailed) {
          SnackBarHelper.showMessage(context, state.message);
        }
      },
      child: IconButton(
        onPressed: () {
          BlocProvider.of<TaskCubit>(context, listen: false).addTask();
        },
        icon: const Icon(
          Icons.send,
          color: Color(0xff8687E7),
        ),
      ),
    );
  }
}

class TaskPriorityBox extends StatefulWidget {
  const TaskPriorityBox({super.key, required this.priority});
  final int priority;

  @override
  State<TaskPriorityBox> createState() => _TaskPriorityBoxState();
}

class _TaskPriorityBoxState extends State<TaskPriorityBox> {
  Color backgroundColor = AppColors.instance.priorityBox;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PriorityCubit, PriorityState>(
      listener: (context, state) {
        if (state is SelectedPriority) {
          if (state.priority != widget.priority) {
            setState(() {
              backgroundColor = AppColors.instance.priorityBox;
            });
          } else {
            setState(() {
              backgroundColor = AppColors.instance.appPurple;
            });
          }
        }
      },
      child: InkWell(
        onTap: () {
          BlocProvider.of<PriorityCubit>(context, listen: false)
              .selectPriority(widget.priority);
        },
        child: Container(
          height: ScreenSizeHelper.height_P(context, 0.08),
          width: ScreenSizeHelper.height_P(context, 0.08),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.flag_outlined),
              BodyMediumText(text: widget.priority.toString())
            ],
          ),
        ),
      ),
    );
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenSizeHelper.width_P(context, 0.35),
      height: ScreenSizeHelper.width_P(context, 0.15),
      child: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: BodyLargeText(
              text: 'Cancel', color: AppColors.instance.appPurple)),
    );
  }
}

class ProceedButton extends StatelessWidget {
  const ProceedButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.sizeOfHeight = 0.35});
  final String title;
  final VoidCallback onPressed;
  final double sizeOfHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenSizeHelper.width_P(context, sizeOfHeight),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.instance.appPurple,
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(3))),
        onPressed: onPressed,
        child: BodyLargeText(
          text: title,
        ),
      ),
    );
  }
}

class SavePriorityButton extends StatelessWidget {
  const SavePriorityButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ProceedButton(
      title: 'Save',
      onPressed: () {
        int pr = BlocProvider.of<PriorityCubit>(context, listen: false)
            .savePriority();
        Navigator.pop(context);
        SnackBarHelper.showMessage(context, 'Priority is set to $pr');
      },
    );
  }
}

class CategoryButton extends StatelessWidget {
  const CategoryButton({super.key, required this.category});
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        In_Memory_Task.categoryId = category.id;
        Navigator.pop(context);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Color(
                  int.parse(category.color),
                ),
                borderRadius: BorderRadius.circular(7)),
            height: ScreenSizeHelper.height_P(context, 0.1),
            width: ScreenSizeHelper.height_P(context, 0.1),
          ),
          BodyLargeText(text: category.name)
        ],
      ),
    );
  }
}

class AddCategoryButton extends StatelessWidget {
  const AddCategoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ProceedButton(
      sizeOfHeight: 0.8,
      title: 'Add Category',
      onPressed: () {
        In_Memory_Category.reset();
        NavigationHelper.navigateTo(context, const CreateNewCategory());
      },
    );
  }
}

class CreateCategoryButton extends StatelessWidget {
  const CreateCategoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ProceedButton(
      sizeOfHeight: 0.5,
      title: 'Create Category',
      onPressed: () {
        BlocProvider.of<CategoriesCubit>(context, listen: false).addCategory();
      },
    );
  }
}
