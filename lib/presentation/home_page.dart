import 'package:blog_app/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog App"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.add))
        ],
      ),
      body: const Column(
        children: [
          BlogCard(),
        ],
      ),
    );
  }
}
