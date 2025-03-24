import 'package:flutter/material.dart';
import 'package:to_do/Model_View/storage/added_category.dart';
import 'package:to_do/general_utils/screen_size_helper.dart';

class BlockPickerListExample extends StatefulWidget {
  const BlockPickerListExample({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BlockPickerListExampleState();
  }
}

class _BlockPickerListExampleState extends State<BlockPickerListExample> {
  Color selectedColor = const Color.fromARGB(255, 124, 33, 42);

  // List of colors to display in the BlockPicker
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.teal,
    Colors.indigo,
    Colors.brown,
    Colors.grey,
    Colors.black,
  ];

  void changeColor(Color color) {
    setState(() {
      selectedColor = color;
    });
    In_Memory_Category.color = colorToHex(color);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenSizeHelper.height_P(context, 0.15),
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Horizontal scroll
        itemCount: colors.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              changeColor(colors[index]);
            },
            child: Container(
              width: 100, // Width of each color block
              height: 100, // Height of each color block
              color: colors[index],
              margin: const EdgeInsets.all(8),
              child: selectedColor == colors[index]
                  ? const Icon(Icons.check, color: Colors.white)
                  : null,
            ),
          );
        },
      ),
    );
  }

  // Utility function to convert Color to hex
  String colorToHex(Color color) {
    return '0xff${color.value.toRadixString(16).toUpperCase()}';
  }
}
