import 'package:flutter/material.dart';

class MyCoursePage extends StatelessWidget {
  const MyCoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Course'),
      ),
      body: const Center(
        child: Text('My Course Page'),
      ),
    );
  }
}
