import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/Model/constants/enums.dart';
import 'package:to_do/Model/models/category_model.dart';
import 'package:to_do/Model_View/cubit/categories/categories_cubit.dart';
import 'package:to_do/Model_View/cubit/login/login_cubit.dart';
import 'package:to_do/Model_View/cubit/priority/priority_cubit.dart';
import 'package:to_do/Model_View/cubit/sign_up/sign_up_cubit.dart';
import 'package:to_do/Model_View/cubit/task/task_crud/task_cubit.dart';
import 'package:to_do/Model_View/storage/added_category.dart';
import 'package:to_do/Model_View/storage/cached_task.dart';
import 'package:to_do/Model_View/storage/in_memory_categories.dart';
import 'package:to_do/View/screens/sub_screens/create_new_category.dart';
import 'package:to_do/View/screens/sub_screens/task_details.dart';
import 'package:to_do/View/widgets/dialogs/add_task_dialog.dart';
import 'package:to_do/View/screens/auth_screens/login_screen.dart';
import 'package:to_do/View/screens/auth_screens/register_screen.dart';
import 'package:to_do/View/theme/theme.dart';
import 'package:to_do/general_utils/screen_size_helper.dart';
import 'package:to_do/View/widgets/visual_utils/themed_text.dart';
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
      ),
    );
  }
}

class ExitButtonInBox extends StatelessWidget {
  const ExitButtonInBox({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: SizedBox(
        height: 50,
        width: 50,
        child: Container(
          decoration: const BoxDecoration(
              color: Color(0xff1D1D1D),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ),
    );
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
          Cached_Task_For_Adding_Fields.reset();
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
          Cached_Task_For_Adding_Fields.date =
              await DialogHelper.dataPicker(context);
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
          DialogHelper.dialogShower(
              context,
              const TaskCategoryDialog(
                mode: TaskFieldsModes.add,
              ));
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
          DialogHelper.dialogShower(
              context, const TaskPriorityDialog(mode: TaskFieldsModes.add));
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
          Cached_Task_For_Updating.instance.task.priority = widget.priority;
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
  const SavePriorityButton({super.key, required this.mode});
  final TaskFieldsModes mode;

  onPressed(BuildContext context) {
    if (mode == TaskFieldsModes.add) {
      int pr =
          BlocProvider.of<PriorityCubit>(context, listen: false).savePriority();
      Navigator.pop(context);
      SnackBarHelper.showMessage(context, 'Priority is set to $pr');
    } else {
      BlocProvider.of<TaskCubit>(context, listen: false)
          .updateTask(UpdateModes.priority);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProceedButton(
      title: 'Save',
      onPressed: () {
        onPressed(context);
      },
    );
  }
}

class CategoryButton extends StatelessWidget {
  onTap(BuildContext context) {
    switch (mode) {
      case TaskFieldsModes.add:
        Cached_Task_For_Adding_Fields.categoryId = category.id;
        break;
      case TaskFieldsModes.modify:
        {
          Cached_Task_For_Updating.instance.task.categoryId = category.id;
          context.read<TaskCubit>().updateTask(UpdateModes.category);
        }

      default:
    }
    Navigator.pop(context);
  }

  const CategoryButton({super.key, required this.category, required this.mode});
  final CategoryModel category;
  final TaskFieldsModes mode;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(context);
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
        NavigationHelper.navigateToAndPassCubit<CategoriesCubit>(
            context, const CreateNewCategory());
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

class EditTitleAndDescriptionButton extends StatelessWidget {
  const EditTitleAndDescriptionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          //TODO: apply on pressed
        },
        icon: const ImageIcon(
          AssetImage('assets/edit.png'),
          color: Colors.white,
        ));
  }
}

class EditTaskProperty extends StatelessWidget {
  const EditTaskProperty(
      {super.key, required this.onPressed, required this.text});
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(3)),
            backgroundColor: AppColors.instance.navigationBarBackground),
        onPressed: onPressed,
        child: BodyMediumText(text: text));
  }
}

class DeleteTaskButton extends StatelessWidget {
  const DeleteTaskButton({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<TaskCubit>().removeTask(id);
        Navigator.pop(context);
      },
      child: const Row(
        children: [
          Icon(
            Icons.delete_forever_outlined,
            color: Color(0xffFF4949),
          ),
          SizedBox(width: 20),
          BodyLargeText(
            text: 'Delete Task',
            color: Color(0xffFF4949),
          )
        ],
      ),
    );
  }
}

class EditTaskDate extends StatelessWidget {
  final String date;

  const EditTaskDate({super.key, required this.date});
  @override
  Widget build(BuildContext context) {
    return EditTaskProperty(
      text: date,
      onPressed: () async {
        var localProvider = context.read<TaskCubit>();
        var date = await DialogHelper.dataPicker(context);
        Cached_Task_For_Updating.instance.task.date = date!;
        localProvider.updateTask(UpdateModes.date);
        NavigationHelper.openPage(
            context, TaskDetails(task: Cached_Task_For_Updating.instance.task));
      },
    );
  }
}

class EditTaskCategory extends StatelessWidget {
  const EditTaskCategory({super.key, required this.categoryId});
  final int categoryId;
  @override
  Widget build(BuildContext context) {
    return EditTaskProperty(
        onPressed: () async {
          await DialogHelper.dialogShowerFuture(
              context, const TaskCategoryDialog(mode: TaskFieldsModes.modify));
          NavigationHelper.openPage(context,
              TaskDetails(task: Cached_Task_For_Updating.instance.task));
        },
        text: In_Memory_Categories.instance.categoryName(categoryId));
  }
}

class EditTaskPriority extends StatelessWidget {
  const EditTaskPriority({super.key, required this.priority});
  final int priority;
  @override
  Widget build(BuildContext context) {
    return EditTaskProperty(
        onPressed: () async {
          await DialogHelper.dialogShowerFuture(
              context, const TaskPriorityDialog(mode: TaskFieldsModes.modify));
          NavigationHelper.openPage(context,
              TaskDetails(task: Cached_Task_For_Updating.instance.task));
        },
        text: priority.toString());
  }
}
