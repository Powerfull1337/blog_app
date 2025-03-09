import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';

class AddBlogPage extends StatelessWidget {
  const AddBlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(12),
            width: double.infinity,
            height: 100,
            decoration: DottedDecoration(),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Pick Image"), Icon(Icons.camera)],
            ),
          )
        ],
      ),
    );
  }
}
