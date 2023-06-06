import 'package:flutter/material.dart';

class PromptPage extends StatelessWidget {
  const PromptPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page 1')),
      body: const Center(child: Text('This is Page 1')),
    );
  }
}