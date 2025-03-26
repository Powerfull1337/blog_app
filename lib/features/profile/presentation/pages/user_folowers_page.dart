import 'package:blog_app/features/profile/presentation/widgets/folowers_card.dart';

import 'package:flutter/material.dart';

class UserFolowersPage extends StatelessWidget {
  const UserFolowersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your followers"),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.filter_alt_outlined))
        ],
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) {
            return const FolowersCard();
          }),
    );
  }
}
