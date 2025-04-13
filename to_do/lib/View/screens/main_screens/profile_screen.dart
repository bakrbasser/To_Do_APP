import 'package:flutter/material.dart';
import 'package:to_do/View/widgets/visual_utils/themed_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BodyLargeText(text: 'Profile'),
      ),
      body: const Column(
          // children: [const ProfileImage(), BodyMediumText(text: In_Memory_Logged_User.instance)],
          ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage(
          'assets/person.png',
        ),
      ),
    );
  }
}
