
import 'package:flutter/material.dart';

class UserFolowedPage extends StatelessWidget {
  const UserFolowedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your followed"),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.filter_alt_outlined))
        ],
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) {
            // return FolowersCard(
            //   sufixWidget: Container(
            //     padding: const EdgeInsets.all(8),
            //     decoration: BoxDecoration(
            //       color: AppColors.blue,
            //       borderRadius: BorderRadius.circular(6),
            //     ),
            //     child: const Center(
            //       child: Text(
            //         "Unfollow",
            //         style: TextStyle(fontWeight: FontWeight.bold),
            //       ),
            //     ),
            //   ),
            //   onTap: () {
            //     NavigationService.push(context, const AnotherUserPage());
            //   },
            // );
            return const SizedBox();
          }),
    );
  }
}
