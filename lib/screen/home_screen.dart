import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feeds'),
        elevation: 0,
        backgroundColor: theme.backgroundColor,
      ),
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}
