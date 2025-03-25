import 'package:flutter/material.dart';

class EditProfileInfoPage extends StatelessWidget {
  const EditProfileInfoPage({super.key, required });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Profile Info",
        ),
        centerTitle: true,
      ),
      body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(user.imageUrl),
                  ),
                ]
              ))
    ));
  
  }
}
