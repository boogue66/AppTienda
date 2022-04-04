import 'package:flutter/material.dart';

class LoadinScreen extends StatelessWidget {
  const LoadinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: const Center(
          child: CircularProgressIndicator(
        color: Colors.pink,
      )),
    );
  }
}
