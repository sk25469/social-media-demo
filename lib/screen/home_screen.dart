import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Feeds',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}
