

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
            return const SizedBox();
            //  return FolowersCard(
            //         avatarUrl: user.avatarUrl,
            //         name: user.name,
            //         sufixWidget: const Text(
            //           "View",
            //           style: TextStyle(
            //               fontSize: 18,
            //               fontWeight: FontWeight.w500,
            //               color: AppColors.greyColor),
            //         ),
            //         onTap: () {
            //           NavigationService.push(context, const AnotherUserPage());
            //         },
            //       );
          }),
    );
  }
}
